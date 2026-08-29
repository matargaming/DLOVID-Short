package com.dlovids.short.auth

import android.widget.Toast
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Visibility
import androidx.compose.material.icons.filled.VisibilityOff
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.dlovids.short.R
import com.dlovids.short.core.Secrets
import com.google.firebase.FirebaseException
import com.google.firebase.auth.*
import java.util.concurrent.TimeUnit

@Composable
fun LoginScreen(
    onLoginSuccess: () -> Unit,
    onAdminSuccess: () -> Unit
) {
    val context = LocalContext.current
    val auth = FirebaseAuth.getInstance()

    var emailPhone by remember { mutableStateOf("") }
    var sandi by remember { mutableStateOf("") }
    var confirm by remember { mutableStateOf("") }
    var otp by remember { mutableStateOf("") }

    var showSandi by remember { mutableStateOf(false) }
    var showConfirm by remember { mutableStateOf(false) }

    var isOtpSent by remember { mutableStateOf(false) }
    var verificationId by remember { mutableStateOf("") }
    var error by remember { mutableStateOf("") }

    fun isEmailValid(s: String) = android.util.Patterns.EMAIL_ADDRESS.matcher(s).matches()
    fun isHpValid(s: String) = s.matches(Regex("^08[0-9]{8,11}$"))

    Column(
        Modifier.fillMaxSize().background(Color(0xFF0A0A0A)).padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Spacer(Modifier.height(24.dp))
        // 1. LOGO DLOVID SHORT DIATAS
        Image(
            painter = painterResource(id = R.drawable.logo_dlovids),
            contentDescription = "Logo DLOVID Short",
            modifier = Modifier.size(120.dp)
        )
        Spacer(Modifier.height(8.dp))
        Text("DLOVID Short", color = Color.White, fontSize = 22.sp)
        Spacer(Modifier.height(32.dp))

        // 2. EMAIL / NO HP
        OutlinedTextField(
            value = emailPhone,
            onValueChange = { emailPhone = it; error = "" },
            label = { Text("Email / No HP") },
            placeholder = { Text("contoh: user@gmail.com / 08123456789") },
            modifier = Modifier.fillMaxWidth(),
            colors = OutlinedTextFieldDefaults.colors(focusedTextColor = Color.White, unfocusedTextColor = Color.White, focusedBorderColor = Color(0xFF8A2BE2), unfocusedBorderColor = Color.Gray)
        )
        Spacer(Modifier.height(12.dp))

        // 3. SANDI + INTIP
        OutlinedTextField(
            value = sandi,
            onValueChange = { sandi = it; error = "" },
            label = { Text("Sandi") },
            visualTransformation = if (showSandi) VisualTransformation.None else PasswordVisualTransformation(),
            trailingIcon = {
                IconButton(onClick = { showSandi = !showSandi }) {
                    Icon(if (showSandi) Icons.Default.VisibilityOff else Icons.Default.Visibility, contentDescription = "intip", tint = Color.White)
                }
            },
            modifier = Modifier.fillMaxWidth(),
            colors = OutlinedTextFieldDefaults.colors(focusedTextColor = Color.White, unfocusedTextColor = Color.White, focusedBorderColor = Color(0xFF8A2BE2), unfocusedBorderColor = Color.Gray),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Password)
        )
        Spacer(Modifier.height(12.dp))

        // 4. CONFIRM + INTIP
        OutlinedTextField(
            value = confirm,
            onValueChange = { confirm = it; error = "" },
            label = { Text("Confirm Sandi") },
            visualTransformation = if (showConfirm) VisualTransformation.None else PasswordVisualTransformation(),
            trailingIcon = {
                IconButton(onClick = { showConfirm = !showConfirm }) {
                    Icon(if (showConfirm) Icons.Default.VisibilityOff else Icons.Default.Visibility, contentDescription = "intip", tint = Color.White)
                }
            },
            modifier = Modifier.fillMaxWidth(),
            colors = OutlinedTextFieldDefaults.colors(focusedTextColor = Color.White, unfocusedTextColor = Color.White, focusedBorderColor = Color(0xFF8A2BE2), unfocusedBorderColor = Color.Gray)
        )
        Spacer(Modifier.height(16.dp))

        // 5. OTP VIA HP/EMAIL
        if (isOtpSent) {
            OutlinedTextField(
                value = otp,
                onValueChange = { otp = it },
                label = { Text("Kode OTP") },
                modifier = Modifier.fillMaxWidth(),
                colors = OutlinedTextFieldDefaults.colors(focusedTextColor = Color.White, unfocusedTextColor = Color.White)
            )
            Spacer(Modifier.height(8.dp))
            Button(
                onClick = {
                    val cred = PhoneAuthProvider.getCredential(verificationId, otp)
                    auth.signInWithCredential(cred).addOnSuccessListener { onLoginSuccess() }
                        .addOnFailureListener { error = "OTP salah - Ditolak" }
                },
                modifier = Modifier.fillMaxWidth(),
                colors = ButtonDefaults.buttonColors(Color(0xFF8A2BE2))
            ) { Text("Verifikasi OTP") }
        } else {
            Button(
                onClick = {
                    // Kirim OTP real via Firebase
                    if (isHpValid(emailPhone)) {
                        val options = PhoneAuthOptions.newBuilder(auth)
                            .setPhoneNumber("+62${emailPhone.substring(1)}")
                            .setTimeout(60L, TimeUnit.SECONDS)
                            .setActivity(context as android.app.Activity)
                            .setCallbacks(object : PhoneAuthProvider.OnVerificationStateChangedCallbacks() {
                                override fun onVerificationCompleted(c: PhoneAuthCredential) {}
                                override fun onVerificationFailed(e: FirebaseException) { error = e.message ?: "OTP gagal" }
                                override fun onCodeSent(vId: String, token: PhoneAuthProvider.ForceResendingToken) {
                                    verificationId = vId
                                    isOtpSent = true
                                    Toast.makeText(context, "OTP dikirim ke HP", Toast.LENGTH_SHORT).show()
                                }
                            }).build()
                        PhoneAuthProvider.verifyPhoneNumber(options)
                    } else if (isEmailValid(emailPhone)) {
                        // OTP via Email Link Firebase
                        auth.sendSignInLinkToEmail(emailPhone, ActionCodeSettings.newBuilder().setUrl("https://dlovid-short.firebaseapp.com").build())
                            .addOnSuccessListener { Toast.makeText(context, "OTP dikirim ke Email", Toast.LENGTH_SHORT).show(); isOtpSent = true }
                    } else {
                        error = "Email/No HP tidak valid"
                    }
                },
                modifier = Modifier.fillMaxWidth(),
                colors = ButtonDefaults.buttonColors(Color.Gray)
            ) { Text("Kirim OTP via HP/Email") }
        }

        Spacer(Modifier.height(16.dp))

        // 6. LOGIN VALIDASI DITOLAK JIKA TIDAK SESUAI
        Button(
            onClick = {
                if (emailPhone.isBlank() || sandi.isBlank()) { error = "Isi semua - Ditolak"; return@Button }
                if (sandi != confirm) { error = "Confirm tidak sama - Ditolak"; return@Button }

                // ADMIN CEK
                if (emailPhone == Secrets.ADMIN_EMAIL) {
                    if (sandi != Secrets.ADMIN_KEY_1) { error = "Sandi admin salah - Ditolak"; return@Button }
                    onAdminSuccess()
                    return@Button
                }

                // USER LOGIN REAL
                if (isEmailValid(emailPhone)) {
                    auth.signInWithEmailAndPassword(emailPhone, sandi)
                        .addOnSuccessListener { onLoginSuccess() }
                        .addOnFailureListener {
                            // Jika belum daftar, buat akun baru
                            auth.createUserWithEmailAndPassword(emailPhone, sandi)
                                .addOnSuccessListener { onLoginSuccess() }
                                .addOnFailureListener { e -> error = "Email/sandi tidak sesuai - Ditolak: ${e.message}" }
                        }
                } else if (isHpValid(emailPhone)) {
                    error = "Gunakan OTP untuk login HP"
                } else {
                    error = "No HP/Email tidak sesuai - Ditolak APK"
                }
            },
            modifier = Modifier.fillMaxWidth().height(52.dp),
            shape = RoundedCornerShape(12.dp),
            colors = ButtonDefaults.buttonColors(Color(0xFF8A2BE2))
        ) { Text("LOGIN", fontSize = 16.sp) }

        if (error.isNotEmpty()) {
            Spacer(Modifier.height(12.dp))
            Text(error, color = Color.Red, fontSize = 13.sp)
        }
    }
}
