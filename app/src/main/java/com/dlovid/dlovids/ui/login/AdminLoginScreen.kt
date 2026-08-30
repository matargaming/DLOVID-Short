package com.dlovid.dlovids.ui.login

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.dlovid.dlovids.BuildConfig

@Composable
fun AdminLoginScreen(onAdminSuccess: () -> Unit) {
    var email by remember { mutableStateOf("") }
    var key1 by remember { mutableStateOf("") }
    var key2 by remember { mutableStateOf("") }
    var key3 by remember { mutableStateOf("") }
    var step by remember { mutableStateOf(1) }
    var error by remember { mutableStateOf("") }

    Column(Modifier.fillMaxSize().padding(24.dp)) {
        Text("PANEL ADMIN DLOVID - 3 LAPIS", style = MaterialTheme.typography.headlineSmall)
        Spacer(Modifier.height(20.dp))

        if (step == 1) {
            OutlinedTextField(value = email, onValueChange = { email = it }, label = { Text("Gmail Admin (ADMIN_EMAIL)") }, modifier = Modifier.fillMaxWidth())
            OutlinedTextField(value = key1, onValueChange = { key1 = it }, label = { Text("Sandi 1 (ADMIN_KEY_1)") }, modifier = Modifier.fillMaxWidth())
            Spacer(Modifier.height(12.dp))
            Button(onClick = {
                if (email == BuildConfig.ADMIN_EMAIL && key1 == BuildConfig.ADMIN_KEY_1) {
                    step = 2; error = ""
                } else error = "Email / Sandi 1 salah - ditolak"
            }, modifier = Modifier.fillMaxWidth()) { Text("Masuk Lapis 1") }
        } else {
            Text("Lapis 1 OK, Masukkan 2 Sandi Lagi")
            OutlinedTextField(value = key2, onValueChange = { key2 = it }, label = { Text("Sandi 2 (ADMIN_KEY_2)") }, modifier = Modifier.fillMaxWidth())
            OutlinedTextField(value = key3, onValueChange = { key3 = it }, label = { Text("Sandi 3 (ADMIN_KEY_3)") }, modifier = Modifier.fillMaxWidth())
            Spacer(Modifier.height(12.dp))
            Button(onClick = {
                if (key2 == BuildConfig.ADMIN_KEY_2 && key3 == BuildConfig.ADMIN_KEY_3) {
                    onAdminSuccess()
                } else error = "Sandi 2 / 3 salah - ditolak"
            }, modifier = Modifier.fillMaxWidth()) { Text("Masuk Panel Admin") }
        }
        if (error.isNotEmpty()) { Spacer(Modifier.height(8.dp)); Text(error, color = MaterialTheme.colorScheme.error) }
    }
}
