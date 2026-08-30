plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
}
android {
    namespace = "com.dlovid.dlovids"
    compileSdk = 34
    defaultConfig {
        applicationId = "com.dlovid.dlovids"
        minSdk = 24
        targetSdk = 34
    }
}
dependencies {
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.squareup.retrofit2:retrofit:2.9.0") // untuk TMDB
    implementation("io.agora.rtc:full-sdk:4.3.0") // untuk LIVE
    implementation("com.midtrans:uikit:1.30.0") // untuk QRIS
    implementation("com.google.android.gms:play-services-ads:22.5.0") // ADMOB
}
