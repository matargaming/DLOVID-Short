package com.dlovid.dlovids

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                var menu by remember { mutableStateOf("login") }
                var isAdmin by remember { mutableStateOf(false) }
                var isVip by remember { mutableStateOf(false) }

                when(menu) {
                    "login" -> LoginScreen(
                        onLoginUser = { email, pass, otp ->
                            // PANEL PENGGUNA: cek Firebase Auth Email/HP + OTP
                            // kalau email/pass tidak sesuai -> tolak
                            menu = "drama"
                        },
                        onLoginAdmin = { email, k1, k2, k3 ->
                            // PANEL ADMIN: cek ADMIN_EMAIL + ADMIN_KEY_1,2,3 dari secret
                            if(email == BuildConfig.ADMIN_EMAIL) {
                                isAdmin = true
                                menu = "admin"
                            }
                        }
                    )
                    "drama" -> DramaScreen(isVip = isVip, onVipClick = { menu = "akun" })
                    "beranda" -> BerandaTiktokScreen(isVip = isVip)
                    "akun" -> AkunScreen(isVip = isVip, onBeliVip = {
                        // Klik VIP -> Midtrans QRIS 30rb/bulan
                        // pakai MIDTRANS_CLIENT_KEY + SERVER_KEY
                        isVip = true
                    })
                    "admin" -> AdminScreen()
                }
            }
        }
    }
}

@Composable
fun LoginScreen(onLoginUser: (String,String,String)->Unit, onLoginAdmin: (String,String,String,String)->Unit) {
    // Logo DLOVID short di atas dari assets/logo_vip.png
    // Field: Email/No HP, Sandi + intip, Confirm + intip, OTP via HP/Email
    // Tombol Login
}

@Composable
fun DramaScreen(isVip: Boolean, onVipClick: ()->Unit) {
    // ATAS: scroll kiri kanan film campuran dari TMDB_API_KEY (ada iklan selesai episode ADMOB_INTER)
    // BAWAH: kolase kotak film -> klik fullscreen vertikal
    // Update otomatis tiap Minggu trending AI
    // Pojok atas: logo VIP kecil -> onVipClick, sebelahnya search
    // Pojok bawah kanan: tombol ganti episode, VIP bebas pilih episode
}

@Composable
fun BerandaTiktokScreen(isVip: Boolean) {
    // Menonton video live & upload pengguna kayak TikTok
    // Live pakai AGORA_APP_ID + AGORA_APP_CERTIFICATE
}

@Composable
fun AkunScreen(isVip: Boolean, onBeliVip: ()->Unit) {
    // Foto + icon pensil, Nama + pensil
    // Kotak pendapatan koin -> tukar rupiah
    // Kotak dompet, Kotak WD ke wallet/bank
    // WD kepotong 20% admin
}

@Composable
fun AdminScreen() {
    // Kotak live berapa iklan ditonton (ADMOB_BANNER_ID)
    // Daftar drama trending TMDB
    // Menu Saran: lihat live, tegur/blokir, hapus video pendek
    // Kotak pendapatan + WD admin ke bank/wallet
}
