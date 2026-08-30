package com.dlovid.dlovids.ui.home

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.dlovid.dlovids.payment.QrisPaymentHandler

@Composable
fun DramaScreen(isVip: Boolean, onVipClick: () -> Unit, onSearchClick: () -> Unit) {
    Column(Modifier.fillMaxSize()) {
        // HEADER: Logo VIP kanan atas + Search
        Row(Modifier.fillMaxWidth().padding(8.dp), horizontalArrangement = Arrangement.End) {
            Button(onClick = onVipClick) { Text(if(isVip) "VIP 👑" else "VIP 30K") }
            Spacer(Modifier.width(8.dp))
            Button(onClick = onSearchClick) { Text("🔍") }
        }

        // 1. FILM ATAS: scroll kiri kanan campuran Drakor/Dracin/Barat/India
        // Ambil dari TMDB_API_KEY - update tiap Minggu AI trending
        LazyRow {
            items(10) { // 10 film trending
                Card(Modifier.size(120.dp, 180.dp).padding(4.dp)) {
                    Text("Drama ${it+1}")
                }
            }
        }

        // 2. BAWAH: Kotak kolase fullscreen vertikal
        LazyVerticalGrid(columns = GridCells.Adaptive(120.dp)) {
            items(20) {
                Card(Modifier.padding(4.dp).fillMaxWidth().height(200.dp)) {
                    Text("Episode ${it+1}")
                    // Klik -> fullscreen vertikal
                    // Jika bukan VIP & habis episode -> ADMOB_INTER_ID
                }
            }
        }

        // 3. Tombol kanan bawah ganti episode
        // VIP bebas pilih episode apa aja
    }
}

@Composable
fun BerandaTiktokScreen() {
    // MENU BERANDA KAYAK TIKTOK
    // - Video live & upload pengguna
    // - Live yang sedang on tampil di sini
    // - Pakai AGORA_APP_ID
}

@Composable
fun PlusScreen(isVip: Boolean, onMintaVip: () -> Unit, onLive: () -> Unit, onUpload: () -> Unit) {
    // KLIK ICON + TENGAH
    // Muncul 2 pilihan: Live atau Upload
    // Kalau Live -> cek isVip, kalau false -> onMintaVip -> QRIS 30rb
    // Kalau Upload -> masuk galeri
    if(!isVip) {
        Button(onClick = { QrisPaymentHandler.buatQrisLive(); onMintaVip() }) {
            Text("Beli VIP 30rb untuk Live")
        }
    } else {
        Button(onClick = onLive) { Text("Mulai Live") }
        Button(onClick = onUpload) { Text("Upload Video") }
    }
}
