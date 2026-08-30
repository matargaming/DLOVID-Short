package com.dlovid.dlovids

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp

// ... MainActivity di atasnya biarin ...

@Composable
fun LoginScreen(onLoginUser: (String,String,String)->Unit, onLoginAdmin: (String,String,String,String)->Unit) {
    Column(
        Modifier.fillMaxSize().padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Image(
            painter = painterResource(id = R.drawable.logo_dlovids), 
            contentDescription = "DLOVIDS",
            modifier = Modifier.size(180.dp)
        )
        Spacer(Modifier.height(24.dp))
        // field Email/HP, Sandi + intip, Confirm + intip, OTP di sini
        Text("Login dengan logo DLOVIDS")
    }
}
