package com.dlovid.dlovids.ui.login

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Visibility
import androidx.compose.material.icons.filled.VisibilityOff
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.unit.dp
import com.dlovid.dlovids.R

@Composable
fun LoginScreen(
    onLoginClick: (emailOrPhone: String, password: String) -> Unit,
    onRegisterClick: (emailOrPhone: String, password: String) -> Unit,
    onOtpClick: (emailOrPhone: String) -> Unit
) {
    var emailOrPhone by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    var confirmPassword by remember { mutableStateOf("") }
    var passwordVisible by remember { mutableStateOf(false) }
    var confirmPasswordVisible by remember { mutableStateOf(false) }
    var errorMessage by remember { mutableStateOf("") }

    val configuration = LocalConfiguration.current
    val isTablet = configuration.screenWidthDp >= 600
    val padding = if (isTablet) 64.dp else 24.dp

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(padding),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Spacer(modifier = Modifier.height(30.dp))

        // 1. LOGO DLOVIDS DI ATAS
        Image(
            painter = painterResource(id = R.drawable.logo_dlovids),
            contentDescription = "Logo DLOVID Short",
            modifier = Modifier
                .width(if (isTablet) 200.dp else 150.dp)
                .height(if (isTablet) 200.dp else 150.dp),
            contentScale = ContentScale.Fit
        )

        Spacer(modifier = Modifier.height(20.dp))

        // 2. EMAIL / NO HP
        OutlinedTextField(
            value = emailOrPhone,
            onValueChange = { emailOrPhone = it; errorMessage = "" },
            label = { Text("Email / No HP") },
            modifier = Modifier.fillMaxWidth(),
            singleLine = true
        )

        Spacer(modifier = Modifier.height(12.dp))

        // 3. SANDI + INTIP
        OutlinedTextField(
            value = password,
            onValueChange = { password = it; errorMessage = "" },
            label = { Text("Sandi") },
            modifier = Modifier.fillMaxWidth(),
            singleLine = true,
            visualTransformation = if (passwordVisible) VisualTransformation.None else PasswordVisualTransformation(),
            trailingIcon = {
                IconButton(onClick = { passwordVisible = !passwordVisible }) {
                    Icon(
                        imageVector = if (passwordVisible) Icons.Filled.Visibility else Icons.Filled.VisibilityOff,
                        contentDescription = "Intip"
                    )
                }
            }
        )

        Spacer(modifier = Modifier.height(12.dp))

        // 4. CONFIRM + INTIP
        OutlinedTextField(
            value = confirmPassword,
            onValueChange = { confirmPassword = it; errorMessage = "" },
            label = { Text("Confirm Sandi") },
            modifier = Modifier.fillMaxWidth(),
            singleLine = true,
            visualTransformation = if (confirmPasswordVisible) VisualTransformation.None else PasswordVisualTransformation(),
            trailingIcon = {
                IconButton(onClick = { confirmPasswordVisible = !confirmPasswordVisible }) {
                    Icon(
                        imageVector = if (confirmPasswordVisible) Icons.Filled.Visibility else Icons.Filled.VisibilityOff,
                        contentDescription = "Intip Confirm"
                    )
                }
            }
        )

        if (errorMessage.isNotEmpty()) {
            Spacer(modifier = Modifier.height(8.dp))
            Text(text = errorMessage, color = MaterialTheme.colorScheme.error)
        }

        Spacer(modifier = Modifier.height(20.dp))

        // 6. LOGIN VALIDASI TOLAK KALAU SALAH
        Button(
            onClick = {
                when {
                    emailOrPhone.isBlank() -> errorMessage = "Email/No HP tidak boleh kosong"
                    password.isBlank() -> errorMessage = "Sandi tidak boleh kosong"
                    password != confirmPassword -> errorMessage = "Confirm sandi tidak sesuai"
                    password.length < 6 -> errorMessage = "Sandi minimal 6 karakter"
                    else -> onLoginClick(emailOrPhone, password)
                }
            },
            modifier = Modifier.fillMaxWidth().height(50.dp)
        ) {
            Text("LOGIN / DAFTAR")
        }

        Spacer(modifier = Modifier.height(12.dp))

        // 5. OTP VIA HP / EMAIL
        OutlinedButton(
            onClick = {
                if (emailOrPhone.isBlank()) {
                    errorMessage = "Isi Email/No HP dulu untuk OTP"
                } else {
                    onOtpClick(emailOrPhone)
                }
            },
            modifier = Modifier.fillMaxWidth().height(50.dp)
        ) {
            Text("Kirim OTP via HP / Email")
        }
    }
}
