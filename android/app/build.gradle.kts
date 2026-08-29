plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.dlovids.short"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.dlovids.short"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        // INI YANG BIKIN ${ADMOB_APP_ID} DI MANIFEST KEBACA
        manifestPlaceholders["ADMOB_APP_ID"] = System.getenv("ADMOB_APP_ID") ?: "ca-app-pub-3940256099942544~3347511713"
    }

    // INI YANG BIKIN Secrets.kt KAMU JALAN
    buildFeatures {
        buildConfig = true
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

    // 14 SECRET REAL - NO DUMMY
    defaultConfig {
        buildConfigField("String", "ADMIN_EMAIL", "\"${System.getenv("ADMIN_EMAIL") ?: ""}\"")
        buildConfigField("String", "ADMIN_KEY_1", "\"${System.getenv("ADMIN_KEY_1") ?: ""}\"")
        buildConfigField("String", "ADMIN_KEY_2", "\"${System.getenv("ADMIN_KEY_2") ?: ""}\"")
        buildConfigField("String", "ADMIN_KEY_3", "\"${System.getenv("ADMIN_KEY_3") ?: ""}\"")
        buildConfigField("String", "TMDB_API_KEY", "\"${System.getenv("TMDB_API_KEY") ?: ""}\"")
        buildConfigField("String", "ADMOB_APP_ID", "\"${System.getenv("ADMOB_APP_ID") ?: ""}\"")
        buildConfigField("String", "ADMOB_BANNER_ID", "\"${System.getenv("ADMOB_BANNER_ID") ?: ""}\"")
        buildConfigField("String", "ADMOB_INTER_ID", "\"${System.getenv("ADMOB_INTER_ID") ?: ""}\"")
        buildConfigField("String", "AGORA_APP_ID", "\"${System.getenv("AGORA_APP_ID") ?: ""}\"")
        buildConfigField("String", "AGORA_APP_CERTIFICATE", "\"${System.getenv("AGORA_APP_CERTIFICATE") ?: ""}\"")
        buildConfigField("String", "MIDTRANS_CLIENT_KEY", "\"${System.getenv("MIDTRANS_CLIENT_KEY") ?: ""}\"")
        buildConfigField("String", "MIDTRANS_SERVER_KEY", "\"${System.getenv("MIDTRANS_SERVER_KEY") ?: ""}\"")
        buildConfigField("String", "FIREBASE_PROJECT_ID", "\"${System.getenv("FIREBASE_PROJECT_ID") ?: ""}\"")
        manifestPlaceholders["ADMOB_APP_ID"] = System.getenv("ADMOB_APP_ID") ?: "ca-app-pub-3940256099942544~3347511713"
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.compose.ui:ui:1.5.8")
    implementation("androidx.compose.material3:material3:1.1.2")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
    implementation("com.google.firebase:firebase-auth:22.3.0")
    implementation("com.google.firebase:firebase-firestore:24.10.0")
    implementation("com.google.firebase:firebase-storage:20.3.0")
    implementation("com.google.android.gms:play-services-ads:23.0.0")
    implementation("io.agora.rtc:full-sdk:4.3.0")
    implementation("androidx.media3:media3-exoplayer:1.2.1")
    implementation("io.coil-kt:coil-compose:2.5.0")
}
