package com.dlovid.short

object MidtransConfig {
    // CLIENT KEY - Aman buat di APK
    const val CLIENT_KEY = "Mid-client-Hptta6Fl9lDFbNQT"
    
    // SERVER KEY - JANGAN TARO DI APK! Taruh di Firebase Function / Backend kamu
    // const val SERVER_KEY = "Mid-server-xxxx" // HAPUS DARI SINI!

    const val MERCHANT_BASE_URL = "https://api.sandbox.midtrans.com/"
    
    // Harga VIP
    const val VIP_PRICE = 15000
    const val VIP_DURATION_DAYS = 30
}
