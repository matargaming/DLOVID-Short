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
        versionCode = 1
        versionName = "1.0"

        // PRIVASI 100% DARI GITHUB SECRETS - TANPA HARDCODE
        val admobAppId = System.getenv("ADMOB_APP_ID") ?: (findProperty("ADMOB_APP_ID") as String? ?: "")
        val admobBannerId = System.getenv("ADMOB_BANNER_ID") ?: (findProperty("ADMOB_BANNER_ID") as String? ?: "")
        val admobInterId = System.getenv("ADMOB_INTER_ID") ?: (findProperty("ADMOB_INTER_ID") as String? ?: "")
        val tmdbKey = System.getenv("TMDB_API_KEY") ?: (findProperty("TMDB_API_KEY") as String? ?: "")
        val agoraId = System.getenv("AGORA_APP_ID") ?: (findProperty("AGORA_APP_ID") as String? ?: "")
        val midtransClient = System.getenv("MIDTRANS_CLIENT_KEY") ?: (findProperty("MIDTRANS_CLIENT_KEY") as String? ?: "")

        manifestPlaceholders["ADMOB_APP_ID"] = admobAppId
        manifestPlaceholders["ADMOB_BANNER_ID"] = admobBannerId
        manifestPlaceholders["ADMOB_INTER_ID"] = admobInterId
        manifestPlaceholders["TMDB_API_KEY"] = tmdbKey
        manifestPlaceholders["AGORA_APP_ID"] = agoraId
        manifestPlaceholders["MIDTRANS_CLIENT_KEY"] = midtransClient
    }
    
    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = "1.8"
    }
    
    buildFeatures {
        compose = true
    }
    
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.4"
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.compose.ui:ui:1.5.4")
    implementation("androidx.compose.material3:material3:1.1.2")
    implementation("androidx.activity:activity-compose:1.8.2")
    implementation("androidx.lifecycle:lifecycle-runtime-compose:2.6.2")
    // Firebase
    implementation("com.google.firebase:firebase-auth:22.3.0")
    implementation("com.google.firebase:firebase-firestore:24.9.1")
    implementation("com.google.firebase:firebase-storage:20.3.0")
    // TMDB
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")
    // Agora Live
    implementation("io.agora.rtc:full-sdk:4.3.0")
    // Midtrans QRIS
    implementation("com.midtrans:uikit:1.30.0")
    // AdMob
    implementation("com.google.android.gms:play-services-ads:22.5.0")
}
