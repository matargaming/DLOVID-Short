package com.dlovids.short.payment

import android.content.Context
import android.webkit.WebView
import android.webkit.WebViewClient
import com.dlovids.short.core.Secrets
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import java.util.*

object MidtransQris {

    private const val SNAP_URL = "https://app.midtrans.com/snap/v1/transactions"
    private const val SANDBOX_URL = "https://app.sandbox.midtrans.com/snap/v1/transactions"

    // REAL: Buat transaksi QRIS 30K
    suspend fun createQris30k(): String? = withContext(Dispatchers.IO) {
        try {
            val uid = FirebaseAuth.getInstance().currentUser?.uid ?: return@withContext null
            val orderId = "DLOVID-VIP-${uid.take(5)}-${System.currentTimeMillis()}"

            val json = JSONObject().apply {
                put("transaction_details", JSONObject().apply {
                    put("order_id", orderId)
                    put("gross_amount", Secrets.vipPrice) // 30000 REAL
                })
                put("customer_details", JSONObject().apply {
                    put("first_name", FirebaseAuth.getInstance().currentUser?.email ?: "User DLOVID")
                    put("email", FirebaseAuth.getInstance().currentUser?.email)
                })
                put("enabled_payments", org.json.JSONArray().apply { put("qris") })
                put("callbacks", JSONObject().apply {
                    put("finish", "https://dlovid-short.web.app/finish")
                })
            }

            val conn = URL(SNAP_URL).openConnection() as HttpURLConnection
            conn.requestMethod = "POST"
            conn.setRequestProperty("Content-Type", "application/json")
            conn.setRequestProperty("Accept", "application/json")
            // REAL SERVER KEY dari secret MIDTRANS_SERVER_KEY
            val auth = Base64.getEncoder().encodeToString("${Secrets.MIDTRANS_SERVER_KEY}:".toByteArray())
            conn.setRequestProperty("Authorization", "Basic $auth")
            conn.doOutput = true
            conn.outputStream.write(json.toString().toByteArray())

            val response = conn.inputStream.bufferedReader().readText()
            val obj = JSONObject(response)
            val token = obj.getString("token")
            val redirect = obj.getString("redirect_url")

            // Simpan pending ke Firestore untuk Admin monitoring
            FirebaseFirestore.getInstance().collection("vip_pending").document(orderId).set(
                mapOf(
                    "uid" to uid,
                    "amount" to Secrets.vipPrice,
                    "qris_url" to redirect,
                    "token" to token,
                    "status" to "pending",
                    "created" to System.currentTimeMillis()
                )
            )

            return@withContext redirect

        } catch (e: Exception) {
            e.printStackTrace()
            return@withContext null
        }
    }

    // REAL: WebView QRIS
    fun showQris(context: Context, webView: WebView, url: String, onSuccess: () -> Unit) {
        webView.settings.javaScriptEnabled = true
        webView.webViewClient = object : WebViewClient() {
            override fun onPageFinished(view: WebView?, url: String?) {
                if (url?.contains("finish") == true || url?.contains("success") == true) {
                    // REAL: Update Firestore jadi VIP
                    val uid = FirebaseAuth.getInstance().currentUser?.uid
                    if (uid != null) {
                        FirebaseFirestore.getInstance().collection("users").document(uid)
                            .update(mapOf("isVip" to true, "vipDate" to System.currentTimeMillis()))
                    }
                    onSuccess()
                }
            }
        }
        webView.loadUrl(url)
    }
}
