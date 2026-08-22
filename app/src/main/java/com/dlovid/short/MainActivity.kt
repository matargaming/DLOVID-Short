 package com.dlovid.short

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.midtrans.sdk.corekit.core.MidtransSDK
import com.midtrans.sdk.corekit.core.themes.CustomColorTheme
import com.midtrans.sdk.uikit.SdkUIFlowBuilder

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Init Midtrans
        initMidtrans()

        // Cek login
        val prefs = getSharedPreferences("DLOVID", MODE_PRIVATE)
        val email = prefs.getString("email", "") ?: ""
        val isLoggedIn = prefs.getBoolean("isLoggedIn", false)

        if (!isLoggedIn) {
            startActivity(Intent(this, LoginActivity::class.java))
            finish()
            return
        }

        // === ADMIN 2 PANEL SWITCH - PASTE DI SINI ===
        if (AdminManager.isAdminEmail(email)) {
            val adminBtn = Button(this).apply {
                text = "ADMIN: 2 PANEL"
                setBackgroundColor(android.graphics.Color.parseColor("#FFD700"))
                setTextColor(android.graphics.Color.BLACK)
                textSize = 12f
                val params = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
                layoutParams = params
                x = 20f
                y = 100f
                setOnClickListener {
                    val options = arrayOf("🔧 Masuk Panel ADMIN", "👤 Masuk Panel USER Biasa")
                    AlertDialog.Builder(this@MainActivity)
                        .setTitle("Admin Terdeteksi: ${email}")
                        .setMessage("Pilih mode:")
                        .setItems(options) { _, which ->
                            if (which == 0) {
                                try {
                                    val intent = Intent(this@MainActivity, Class.forName("com.dlovid.short.AdminActivity"))
                                    startActivity(intent)
                                } catch (e: Exception) {
                                    Toast.makeText(this@MainActivity, "AdminActivity belum ada, buat dulu bos!", Toast.LENGTH_LONG).show()
                                }
                            } else {
                                Toast.makeText(this@MainActivity, "Mode USER aktif - kamu lihat sebagai user biasa", Toast.LENGTH_SHORT).show()
                            }
                        }
                        .setNegativeButton("Tutup", null)
                        .show()
                }
            }
            try {
                (findViewById<View>(android.R.id.content) as ViewGroup).addView(adminBtn)
            } catch (e: Exception) {
                // fallback
            }
        }
        // === END ADMIN SWITCH ===

        // Lanjut logic home kamu
        // ...
    }

    private fun initMidtrans() {
        try {
            SdkUIFlowBuilder.init()
                .setContext(this)
                .setMerchantBaseUrl(MidtransConfig.MERCHANT_BASE_URL)
                .setClientKey(MidtransConfig.CLIENT_KEY)
                .setTransactionFinishedCallback { result ->
                    // handle result
                }
                .setColorTheme(CustomColorTheme("#FFD700", "#FFD700", "#FFD700"))
                .buildSDK()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
