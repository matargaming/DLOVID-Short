package com.dlovid.dlovids.payment

object QrisPaymentHandler {
    // Harga dari konsep kamu
    const val VIP_1_BULAN = 30000
    const val VIP_1_TAHUN = 300000
    const val PAKET_LIVE_VIP = 30000
    const val POTONGAN_WD_ADMIN = 0.20 // 20%

    // Ini dipanggil waktu user klik logo VIP kecil pojok kanan atas
    // Pakai MIDTRANS_CLIENT_KEY dari secret kamu
    fun buatQrisVip(bulan: Int): String {
        // 1. Panggil Midtrans Snap API
        // 2. Generate QRIS 30rb
        // 3. Tampilkan di Menu Akun
        return "https://api.midtrans.com/qris/vip/$bulan"
    }

    // Dipanggil waktu user mau LIVE dari menu + 
    fun buatQrisLive(): String {
        // Harus beli VIP dulu baru bisa live
        // Harga sama 30rb
        return buatQrisVip(1)
    }

    // Hitungan WD user ke wallet/bank - dipotong 20% buat admin
    fun hitungWdDiterima(totalWd: Long): Long {
        val potongan = (totalWd * POTONGAN_WD_ADMIN).toLong()
        return totalWd - potongan // user terima 80%
    }

    fun hitungPendapatanAdmin(totalWd: Long): Long {
        return (totalWd * POTONGAN_WD_ADMIN).toLong() // admin dapat 20%
    }

    // Callback dari MIDTRANS_SERVER_KEY
    fun onPembayaranSukses(userId: String) {
        // Update Firestore: users/{userId}/isVip = true
        // Update expiredAt = sekarang + 30 hari
    }
}
