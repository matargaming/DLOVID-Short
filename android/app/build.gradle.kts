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
    }

    // INI YANG KURANG DI SCREENSHOT KAMU - WAJIB ADA
    buildFeatures {
        buildConfig = true
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }

    // INI SUDAH BENAR DARI FOTO KAMU - TINGGAL TARUH DI DALAM
    // INI YANG ARAHKAN KE 13 SECRET KAMU - NO DUMMY
    defaultConfig {
        buildConfigField("String","ADMIN_EMAIL","\"${System.getenv("ADMIN_EMAIL")}\"")
        buildConfigField("String","ADMIN_KEY_1","\"${System.getenv("ADMIN_KEY_1")}\"")
        buildConfigField("String","ADMIN_KEY_2","\"${System.getenv("ADMIN_KEY_2")}\"")
        buildConfigField("String","ADMIN_KEY_3","\"${System.getenv("ADMIN_KEY_3")}\"")
        buildConfigField("String","TMDB_API_KEY","\"${System.getenv("TMDB_API_KEY")}\"")
        buildConfigField("String","ADMOB_APP_ID","\"${System.getenv("ADMOB_APP_ID")}\"")
        buildConfigField("String","ADMOB_BANNER_ID","\"${System.getenv("ADMOB_BANNER_ID")}\"")
        buildConfigField("String","ADMOB_INTER_ID","\"${System.getenv("ADMOB_INTER_ID")}\"")
        buildConfigField("String","AGORA_APP_ID","\"${System.getenv("AGORA_APP_ID")}\"")
        buildConfigField("String","AGORA_APP_CERTIFICATE","\"${System.getenv("AGORA_APP_CERTIFICATE")}\"")
        buildConfigField("String","MIDTRANS_CLIENT_KEY","\"${System.getenv("MIDTRANS_CLIENT_KEY")}\"")
        buildConfigField("String","MIDTRANS_SERVER_KEY","\"${System.getenv("MIDTRANS_SERVER_KEY")}\"")
        buildConfigField("String","FIREBASE_PROJECT_ID","\"${System.getenv("FIREBASE_PROJECT_ID")}\"")
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.compose.ui:ui:1.5.8")
    implementation("com.google.firebase:firebase-auth:22.3.0")
    implementation("com.google.firebase:firebase-firestore:24.10.0")
    implementation("com.google.firebase:firebase-storage:20.3.0")
}
