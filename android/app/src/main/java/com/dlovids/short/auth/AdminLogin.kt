package com.dlovids.short.admin

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
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
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.dlovids.short.core.Secrets

class AdminLogin : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { AdminLoginScreen { startActivity(Intent(this, AdminDashboardActivity::class.java)); finish() } }
    }
}

@Composable
fun AdminLoginScreen(onSuccess: () -> Unit) {
    var step by remember { mutableStateOf(1) } // 1 = email+key1, 2 = key2+key3

    var email by remember { mutableStateOf("") }
    var key1 by remember { mutableStateOf("") }
    var key2 by remember { mutableStateOf("") }
    var key3 by remember { mutableStateOf("") }

    var show1 by remember { mutableStateOf(false) }
    var show2 by remember { mutableStateOf(false) }
    var show3 by remember { mutableStateOf(false) }

    var error by remember { mutableStateOf("") }

    Column(
        Modifier.fillMaxSize().background(Color(0xFF0A0A0A)).padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text("ADMIN DLOVID SHORT", color = Color.Red, fontSize = 22.sp)
        Text("3 Lapis Keamanan", color = Color.Gray, fontSize = 12.sp)
        Spacer(Modifier.height(32.dp))

        if (step == 1) {
            // STEP 1: EMAIL + KEY 1
            OutlinedTextField(
                value = email,
                onValueChange = { email = it; error = "" },
                label = { Text("Gmail Admin") },
                modifier = Modifier.fillMaxWidth(),
                colors = OutlinedTextFieldDefaults.colors(focusedBorderColor = Color.Red, unfocusedBorderColor = Color.Gray, focusedTextColor = Color.White, unfocusedTextColor = Color.White)
            )
            Spacer(Modifier.height(12.dp))
            OutlinedTextField(
                value = key1,
                onValueChange = { key1 = it; error = "" },
                label = { Text("ADMIN_KEY_1") },
                visualTransformation = if (show1) VisualTransformation.None else PasswordVisualTransformation(),
                trailingIcon = {
                    IconButton(onClick = { show1 = !show1 }) {
                        Icon(if (show1) Icons.Default.VisibilityOff else Icons.Default.Visibility, contentDescription = null, tint = Color.White)
                    }
                },
                modifier = Modifier.fillMaxWidth(),
                colors = OutlinedTextFieldDefaults.colors(focusedBorderColor = Color.Red, unfocusedBorderColor = Color.Gray, focusedTextColor = Color.White, unfocusedTextColor = Color.White),
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Password)
            )
            Spacer(Modifier.height(20.dp))
            Button(
                onClick = {
                    // VALIDASI REAL DARI SECRET
                    if (email.trim() != Secrets.ADMIN_EMAIL) {
                        error = "ADMIN_EMAIL tidak sesuai - Ditolak"
                    } else if (key1 != Secrets.ADMIN_KEY_1) {
                        error = "ADMIN_KEY_1 salah - Ditolak"
                    } else {
                        step = 2
                        error = ""
                    }
                },
                modifier = Modifier.fillMaxWidth().height(50.dp),
                shape = RoundedCornerShape(12.dp),
                colors = ButtonDefaults.buttonColors(Color.Red)
            ) { Text("Lanjut Lapis 2 & 3") }

        } else {
            // STEP 2: KEY 2 + KEY 3
            Text("Verifikasi Lapis 2 & 3", color = Color.White, fontSize = 18.sp)
            Spacer(Modifier.height(16.dp))
            OutlinedTextField(
                value = key2,
                onValueChange = { key2 = it; error = "" },
                label = { Text("ADMIN_KEY_2") },
                visualTransformation = if (show2) VisualTransformation.None else PasswordVisualTransformation(),
                trailingIcon = {
                    IconButton(onClick = { show2 = !show2 }) {
                        Icon(if (show2) Icons.Default.VisibilityOff else Icons.Default.Visibility, contentDescription = null, tint = Color.White)
                    }
                },
                modifier = Modifier.fillMaxWidth(),
                colors = OutlinedTextFieldDefaults.colors(focusedBorderColor = Color.Red, unfocusedBorderColor = Color.Gray, focusedTextColor = Color.White, unfocusedTextColor = Color.White)
            )
            Spacer(Modifier.height(12.dp))
            OutlinedTextField(
                value = key3,
                onValueChange = { key3 = it; error = "" },
                label = { Text("ADMIN_KEY_3") },
                visualTransformation = if (show3) VisualTransformation.None else PasswordVisualTransformation(),
                trailingIcon = {
                    IconButton(onClick = { show3 = !show3 }) {
                        Icon(if (show3) Icons.Default.VisibilityOff else Icons.Default.Visibility, contentDescription = null, tint = Color.White)
                    }
                },
                modifier = Modifier.fillMaxWidth(),
                colors = OutlinedTextFieldDefaults.colors(focusedBorderColor = Color.Red, unfocusedBorderColor = Color.Gray, focusedTextColor = Color.White, unfocusedTextColor = Color.White)
            )
            Spacer(Modifier.height(20.dp))
            Button(
                onClick = {
                    if (key2 != Secrets.ADMIN_KEY_2) {
                        error = "ADMIN_KEY_2 salah - Ditolak"
                    } else if (key3 != Secrets.ADMIN_KEY_3) {
                        error = "ADMIN_KEY_3 salah - Ditolak
