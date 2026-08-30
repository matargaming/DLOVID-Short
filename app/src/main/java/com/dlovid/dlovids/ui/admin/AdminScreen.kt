package com.dlovid.dlovids.ui.admin

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun AdminScreen() {
    Column(Modifier.padding(16.dp)) {
        Text("PANEL ADMIN - DLOVID Short", style = MaterialTheme.typography.titleLarge)

        // 1. KOTAK LIVE IKLAN
        Card(Modifier.fillMaxWidth().padding(8.dp)) {
            Column(Modifier.padding(12.dp)) {
                Text("📊 Iklan Ditonton")
                Text("ADMOB_BANNER_ID + INTER_ID")
                Text("Live count dari AdMob")
            }
        }

        // 2. DAFTAR DRAMA TRENDING TMDB
        Card(Modifier.fillMaxWidth().padding(8.dp)) {
            Column(Modifier.padding(12.dp)) {
                Text("🔥 Drama Trending TMDB")
                Text("Update otomatis tiap Minggu - atur oleh AI")
                Text("TMDB_API_KEY dari secret")
            }
        }

        // 3. MENU SARAN - LIVE
        Card(Modifier.fillMaxWidth().padding(8.dp)) {
            Column(Modifier.padding(12.dp)) {
                Text("MENU SARAN")
                Text("• Lihat pengguna yang sedang live")
                Text("• Tegur / Blokir akun kalau pelanggaran")
                Text("• Pakai AGORA_APP_ID")
                Button(onClick = {}) { Text("Blokir User") }
            }
        }

        // 4. SELEKSI VIDEO PENDEK
        Card(Modifier.fillMaxWidth().padding(8.dp)) {
            Column(Modifier.padding(12.dp)) {
                Text("Video Pendek Upload")
                Text("Admin bisa seleksi & hapus")
                Button(onClick = {}) { Text("Hapus Video") }
            }
        }

        // 5. KEUANGAN ADMIN
        Card(Modifier.fillMaxWidth().padding(8.dp)) {
            Column(Modifier.padding(12.dp)) {
                Text("💰 Pendapatan Admin")
                Text("WD User potongan 20%")
                Text("WD Admin ke bank/wallet bebas")
            }
        }
    }
}
