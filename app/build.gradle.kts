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
        versionName = "1.0.0"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        val tmdbKey: String = (project.findProperty("TMDB_API_KEY") as String?)?: System.getenv("TMDB_API_KEY")?: ""
        val agoraId: String = (project.findProperty("AGORA_APP_ID") as String?)?: System.getenv("AGORA_APP_ID")?: "7295aa6c772447bcab2457c625fc1be4"
        val admobAppId: String = (project.findProperty("ADMOB_APP_ID") as String?)?: System.getenv("ADMOB_APP_ID")?: "ca-app-pub-3940256099942544~3347511713"
        manifestPlaceholders["ADMOB_APP_ID"] = admobAppId
        buildConfigField("String", "TMDB_API_KEY", "\"${tmdbKey}\"")
        buildConfigField("String", "AGORA_APP_ID", "\"${agoraId}\"")
        buildConfigField("String", "ADMOB_APP_ID", "\"${admobAppId}\"")
        buildConfigField("String", "ADMIN_EMAIL", "\"${System.getenv("ADMIN_EMAIL")?: ""}\"")
        buildConfigField("String", "ADMIN_KEY_1", "\"${System.getenv("ADMIN_KEY_1")?: ""}\"")
        buildConfigField("String", "ADMIN_KEY_2", "\"${System.getenv("ADMIN_KEY_2")?: ""}\"")
        buildConfigField("String", "ADMIN_KEY_3", "\"${System.getenv("ADMIN_KEY_3")?: ""}\"")
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }
    buildFeatures {
        compose = true
        buildConfig = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.8"
    }
    packaging {
        resources { excludes += "/META-INF/{AL2.0,LGPL2.1}" }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
    implementation("androidx.activity:activity-compose:1.8.2")
    implementation(platform("androidx.compose:compose-bom:2024.02.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.material:material-icons-extended")
    implementation("androidx.navigation:navigation-compose:2.7.6")
    implementation("com.google.firebase:firebase-auth-ktx:22.3.0")
    implementation("com.google.firebase:firebase-firestore-ktx:24.9.1")
    implementation("com.google.firebase:firebase-storage-ktx:20.3.0")
    implementation("com.google.android.gms:play-services-auth:20.7.0")
    implementation("com.google.android.gms:play-services-ads:22.6.0")
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("androidx.media3:media3-exoplayer:1.2.0")
    implementation("androidx.media3:media3-ui:1.2.0")
}
