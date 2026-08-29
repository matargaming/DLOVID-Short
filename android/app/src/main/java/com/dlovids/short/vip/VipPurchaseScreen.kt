package com.dlovids.short.vip

import android.util.Base64
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
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject

@Composable
fun VipPurchaseScreen(onVipSuccess: () -> Unit) {
    val uid = FirebaseAuth.getInstance().currentUser?.uid ?: ""
    var qrUrl by remember { mutableStateOf<String?>(null) }
    var loading by remember { mutableStateOf(false) }

    suspend fun createQrisReal(): String? {
        val serverKey = Secrets.MIDTRANS_SERVER_KEY
        val auth = Base64.encodeToString("$serverKey:".toByteArray(), Base64.NO_WRAP)

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
            .post(json.toString().toRequestBody("application/json".toMediaType()))
            .build()

        val res = client.newCall(request).execute()
        val body = res.body?.string() ?: return null
        val obj = JSONObject(body)
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
            AndroidView(factory = { WebView(it).apply { loadUrl(qrUrl!!) } }, modifier = Modifier.fillMaxSize())

            Button(onClick = {
                FirebaseFirestore.getInstance().collection("users").document(uid).update("vip", true)
                onVipSuccess()
            }, modifier = Modifier.fillMaxWidth()) {
                Text("Saya Sudah Bayar - Aktifkan VIP")
            }
        }
    }
}
