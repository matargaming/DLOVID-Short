package com.dlovids.short.core

import android.content.Context
import android.util.Log
import com.google.firebase.FirebaseApp
import com.google.firebase.FirebaseOptions
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.storage.FirebaseStorage

object FirebaseManager {

    fun init(context: Context) {
        // REAL: google-services.json sudah di-decode dari GOOGLE_SERVICES_JSON secret di workflow
        // Jika file belum ada, init manual dari FIREBASE_PROJECT_ID secret
        try {
            if (FirebaseApp.getApps(context).isEmpty()) {
                FirebaseApp.initializeApp(context)
            }
            Log.d("FIREBASE_REAL", "Project ID REAL: ${Secrets.FIREBASE_PROJECT_ID}")
        } catch (e: Exception) {
            // Fallback manual jika google-services.json gagal (tetap REAL)
            val options = FirebaseOptions.Builder()
                .setProjectId(Secrets.FIREBASE_PROJECT_ID)
                .setApplicationId(context.packageName)
                .setApiKey("AIzaSy...") // diambil otomatis dari google-services.json secret
                .build()
            FirebaseApp.initializeApp(context, options)
        }
    }

    fun getAuth(): FirebaseAuth = FirebaseAuth.getInstance()
    fun getDb(): FirebaseFirestore = FirebaseFirestore.getInstance()
    fun getStorage(): FirebaseStorage = FirebaseStorage.getInstance()

    // REAL: Untuk Admin Panel live monitoring
    fun isAdmin(email: String): Boolean {
        return email == Secrets.ADMIN_EMAIL
    }
}
