package com.dlov.gold.ui.home

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

@Composable
fun HomeScreen(isVip: Boolean) {
    Column {
        // 1. ATAS: Horizontal scroll dari TMDB_API_KEY
        // 2. BAWAH: Kolase grid drama fullscreen vertikal
        // 3. Jika bukan VIP & habis episode -> tampil AdMob Inter ID
        // 4. Ikon VIP pojok kanan atas -> klik -> QrisPaymentHandler.generateQrisVip(1)
        // 5. Ikon search sebelah VIP
        // 6. Tombol ganti episode kanan bawah
    }
}

@Composable
fun BerandaTiktokScreen() {
    // Feed video pendek + live dari Agora
    // Cek isVip untuk yang live
}
