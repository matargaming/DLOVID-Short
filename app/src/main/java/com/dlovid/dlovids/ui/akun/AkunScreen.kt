package com.dlovid.dlovids.ui.akun
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import com.dlovid.dlovids.payment.QrisPaymentHandler

@Composable
fun AkunScreen(isVip: Boolean, saldo: Long) {
    // Foto + icon pensil, Nama + pensil
    // Kotak pendapatan koin -> tukar rupiah
    // Kotak dompet
    // Kotak WD ke wallet/bank -> pakai hitungWdDiterima()
    val diterima = QrisPaymentHandler.hitungWdDiterima(saldo)
    Text("WD Diterima: Rp $diterima (potongan 20% admin)")
}
