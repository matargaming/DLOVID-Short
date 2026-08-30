package com.dlovid.dlovids.ui.login

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun OtpScreen(emailOrPhone: String, onVerify: (otp: String) -> Unit) {
    var otp by remember { mutableStateOf("") }
    Column(Modifier.fillMaxSize().padding(24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
        Spacer(Modifier.height(40.dp))
        Text("Kode OTP dikirim ke", style = MaterialTheme.typography.titleMedium)
        Text(emailOrPhone, style = MaterialTheme.typography.titleLarge)
        Spacer(Modifier.height(20.dp))
        OutlinedTextField(value = otp, onValueChange = { otp = it }, label = { Text("Masukkan OTP") }, modifier = Modifier.fillMaxWidth())
        Spacer(Modifier.height(20.dp))
        Button(onClick = { onVerify(otp) }, modifier = Modifier.fillMaxWidth().height(50.dp)) {
            Text("Verifikasi OTP")
        }
    }
}
