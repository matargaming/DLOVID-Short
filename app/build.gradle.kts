plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
}

import java.util.Properties
import java.io.FileInputStream

val localProps = Properties()
val localFile = rootProject.file("local.properties")
if (localFile.exists()) {
    localProps.load(FileInputStream(localFile))
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

        // SEMUA 14 SECRET - VERSI KOTLIN
        buildConfigField("String", "ADMOB_APP_ID", "\"${localProps.getProperty("ADMOB_APP_ID", "")}\"")
        buildConfigField("String", "ADMOB_BANNER_ID", "\"${localProps.getProperty("ADMOB_BANNER_ID", "")}\"")
        buildConfigField("String", "ADMOB_INTER_ID", "\"${localProps.getProperty("ADMOB_INTER_ID", "")}\"")
        buildConfigField("String", "AGORA_APP_ID", "\"${localProps.getProperty("AGORA_APP_ID", "")}\"")
        buildConfigField("String", "AGORA_CERT", "\"${localProps.getProperty("AGORA_APP_CERTIFICATE", "")}\"")
        buildConfigField("String", "TMDB_API_KEY", "\"${localProps.getProperty("TMDB_API_KEY", "")}\"")
        buildConfigField("String", "MIDTRANS_CLIENT_KEY", "\"${localProps.getProperty("MIDTRANS_CLIENT_KEY", "")}\"")
        buildConfigField("String", "MIDTRANS_SERVER_KEY", "\"${localProps.getProperty("MIDTRANS_SERVER_KEY", "")}\"")
        buildConfigField("String", "ADMIN_EMAIL", "\"${localProps.getProperty("ADMIN_EMAIL", "")}\"")
        buildConfigField("String", "ADMIN_KEY_1", "\"${localProps.getProperty("ADMIN_KEY_1", "")}\"")
        buildConfigField("String", "ADMIN_KEY_2", "\"${localProps.getProperty("ADMIN_KEY_2", "")}\"")
        buildConfigField("String", "ADMIN_KEY_3", "\"${localProps.getProperty("ADMIN_KEY_3", "")}\"")
        buildConfigField("String", "FIREBASE_PROJECT_ID", "\"${localProps.getProperty("FIREBASE_PROJECT_ID", "")}\"")
    }

    buildFeatures {
        buildConfig = true
    }
    
    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }
}

dependencies {
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.android.gms:play-services-ads:22.5.0")
    implementation("io.agora.rtc:full-sdk:4.2.6")
}
