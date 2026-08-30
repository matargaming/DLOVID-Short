package com.dlovids.short

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.dlovids.short.core.FirebaseManager
import com.dlovids.short.core.Secrets
import com.google.firebase.FirebaseApp

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // REAL: google-services.json sudah di-decode dari GOOGLE_SERVICES_JSON secret di workflow
        // Init Firebase REAL project: dlovids-short
        if (FirebaseApp.getApps(this).isEmpty()) {
            FirebaseApp.initializeApp(this)
        }
        FirebaseManager.init(this)

        // Log REAL secrets (cuma 4 char awal buat verifikasi)
        android.util.Log.d("DLOVIDS_REAL", "FIREBASE: ${Secrets.FIREBASE_PROJECT_ID}")
        android.util.Log.d("DLOVIDS_REAL", "TMDB: ${Secrets.TMDB_API_KEY.take(4)}***")
        android.util.Log.d("DLOVIDS_REAL", "ADMOB: ${Secrets.ADMOB_APP_ID.take(4)}***")
        android.util.Log.d("DLOVIDS_REAL", "AGORA: ${Secrets.AGORA_APP_ID.take(4)}***")
        android.util.Log.d("DLOVIDS_REAL", "MIDTRANS: ${Secrets.MIDTRANS_CLIENT_KEY.take(4)}***")
        android.util.Log.d("DLOVIDS_REAL", "ADMIN: ${Secrets.ADMIN_EMAIL}")

        setContent {
            DlovidsApp()
        }
    }
}
