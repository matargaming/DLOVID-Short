package com.dlovid.dlovids

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.*
import androidx.compose.runtime.*

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            var isAdmin by remember { mutableStateOf(false) }
            var isVip by remember { mutableStateOf(false) }
            
            // LOGIC LOGIN:
            // 1. Cek Firebase Auth Email/HP + OTP
            // 2. Jika email == ADMIN_EMAIL (dari secret) -> minta ADMIN_KEY_1,2,3
            // 3. Jika bukan admin -> cek Firestore users/isVip
            
            // LOGIC VIP QRIS:
            // Klik icon VIP -> Midtrans SDK pakai MIDTRANS_CLIENT_KEY -> generate QRIS 30rb
            // Callback MIDTRANS_SERVER_KEY -> update isVip = true di Firestore
            
            // LOGIC DRAMA:
            // Ambil dari TMDB_API_KEY setiap Minggu
            
            // LOGIC LIVE:
            // Pakai AGORA_APP_ID + AGORA_APP_CERTIFICATE
            // Cek isVip dulu sebelum live
            
            Text("Rangka DLOVID Short - com.dlovid.dlovids - Ready")
        }
    }
}
