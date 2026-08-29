package com.dlovids.short.core

import com.dlovids.short.BuildConfig

object Secrets {

    // ADMIN - 4 Secret
    val ADMIN_EMAIL = BuildConfig.ADMIN_EMAIL
    val ADMIN_KEY_1 = BuildConfig.ADMIN_KEY_1
    val ADMIN_KEY_2 = BuildConfig.ADMIN_KEY_2
    val ADMIN_KEY_3 = BuildConfig.ADMIN_KEY_3

    // TMDB - 1 Secret
    val TMDB_API_KEY = BuildConfig.TMDB_API_KEY
    const val TMDB_BASE_URL = "https://api.themoviedb.org/3/"
    const val TMDB_IMAGE_URL = "https://image.tmdb.org/t/p/w500"

    // ADMOB - 3 Secret
    val ADMOB_APP_ID = BuildConfig.ADMOB_APP_ID
    val ADMOB_BANNER_ID = BuildConfig.ADMOB_BANNER_ID
    val ADMOB_INTER_ID = BuildConfig.ADMOB_INTER_ID

    // AGORA - 2 Secret
    val AGORA_APP_ID = BuildConfig.AGORA_APP_ID
    val AGORA_APP_CERTIFICATE = BuildConfig.AGORA_APP_CERTIFICATE

    // MIDTRANS QRIS VIP 30K - 2 Secret
    val MIDTRANS_CLIENT_KEY = BuildConfig.MIDTRANS_CLIENT_KEY
    val MIDTRANS_SERVER_KEY = BuildConfig.MIDTRANS_SERVER_KEY
    const val VIP_PRICE = 30000L

    // FIREBASE - 2 Secret
    val FIREBASE_PROJECT_ID = BuildConfig.FIREBASE_PROJECT_ID
    // GOOGLE_SERVICES_JSON sudah jadi file app/google-services.json via workflow
}
