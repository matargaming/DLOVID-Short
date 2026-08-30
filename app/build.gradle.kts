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

        val admobAppId = System.getenv("ADMOB_APP_ID") ?: ""
        val admobBannerId = System.getenv("ADMOB_BANNER_ID") ?: ""
        val admobInterId = System.getenv("ADMOB_INTER_ID") ?: ""
        manifestPlaceholders["ADMOB_APP_ID"] = admobAppId
        manifestPlaceholders["ADMOB_BANNER_ID"] = admobBannerId
        manifestPlaceholders["ADMOB_INTER_ID"] = admobInterId
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
    implementation("com.google.firebase:firebase-auth:22.3.0")
    implementation("com.google.firebase:firebase-firestore:24.9.1")
    implementation("com.google.firebase:firebase-storage:20.3.0")
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")
    implementation("io.agora.rtc:full-sdk:4.3.0")
    implementation("com.midtrans:uikit:1.30.0")
    implementation("com.google.android.gms:play-services-ads:22.5.0")
}
