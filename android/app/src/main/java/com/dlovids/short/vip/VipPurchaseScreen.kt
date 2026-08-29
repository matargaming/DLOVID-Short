package com.dlovids.short.vip

import android.webkit.WebView
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import com.dlovids.short.core.Secrets
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import org.json.JSONObject
import java.util.Base64
import okhttp3.*

@Composable
fun VipPurchaseScreen(onVipSuccess: () -> Unit) {
    val context = LocalContext.current
    val uid = FirebaseAuth.getInstance().currentUser?.uid ?: ""
    var qrUrl by remember { mutableStateOf<String?>(null) }
    var loading by remember { mutableStateOf(false) }

    suspend fun createQrisReal(): String? {
        // REAL: Midtrans QRIS API pakai MIDTRANS_SERVER_KEY secret
        val serverKey = Secrets.MIDTRANS_SERVER_KEY
        val auth = Base64.getEncoder().encodeToString("$serverKey:".toByteArray())

        val json = JSONObject().apply {
            put("payment_type", "qris")
            put("transaction_details", JSONObject().apply {
                put("order_id", "VIP_${uid}_${System.currentTimeMillis()}")
                put("gross_amount", Secrets.VIP_PRICE)
            })
            put("customer_details", JSONObject().apply {
                put("email", FirebaseAuth.getInstance().currentUser?.email)
            })
        }

        val client = OkHttpClient()
        val request = Request.Builder()
            .url("https://api.sandbox.midtrans.com/v2/charge")
            .addHeader("Authorization", "Basic $auth")
            .addHeader("Content-Type", "application/json")
            .post(RequestBody.create(MediaType.parse("application/json"), json.toString()))
            .build()

        val res = client.newCall(request).execute()
        val body = res.body()?.string() ?: return null
        val obj = JSONObject(body)
        // qr_string atau actions -> qris
        return if (obj.has("actions")) {
            obj.getJSONArray("actions").getJSONObject(0).getString("url")
        } else obj.optString("qr_string")
    }

    Column(Modifier.fillMaxSize().background(Color.Black).padding(16.dp)) {
        Text("VIP 30K REAL - QRIS", color = Color.White)
        Text("Client Key: ${Secrets.MIDTRANS_CLIENT_KEY.take(6)}***", color = Color.Gray)

        Spacer(Modifier.height(16.dp))

        if (qrUrl == null) {
            Button(
                onClick = {
                    loading = true
                    // Launch IO
                    Thread {
                        try {
                            val url = kotlinx.coroutines.runBlocking { createQrisReal() }
                            qrUrl = url
                        } catch (e: Exception) { e.printStackTrace() }
                        loading = false
                    }.start()
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text(if (loading) "Membuat QRIS REAL..." else "Bayar VIP 30K QRIS")
            }
        } else {
            // Tampilkan QRIS WebView
            AndroidView(factory = { WebView(it).apply { loadUrl(qrUrl!!) } }, modifier = Modifier.fillMaxSize())

            Button(onClick = {
                // REAL: Setelah bayar, set VIP di Firestore
                FirebaseFirestore.getInstance().collection("users").document(uid).update("vip", true)
                onVipSuccess()
            }, modifier = Modifier.fillMaxWidth()) {
                Text("Saya Sudah Bayar - Aktifkan VIP")
            }
        }
    }
}
