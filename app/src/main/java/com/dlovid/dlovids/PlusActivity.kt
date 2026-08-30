package com.dlovid.dlovids

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class PlusActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(60, 100, 60, 60)
        }

        val tv = TextView(this).apply {
            text = "➕ MENU PLUS\n\nSeperti TikTok saat klik plus ada pilihan live\n/ unggah video galeri\nDan live wajib membeli VIP 1 BLN QRIS 30.000"
            textSize = 16f
            setPadding(0, 0, 0, 40)
        }

        val btnLive = Button(this).apply {
            text = "🔴 LIVE (Wajib VIP 30rb)"
        }
        val btnUpload = Button(this).apply {
            text = "📁 Upload Video Galeri"
        }
        val status = TextView(this)

        btnLive.setOnClickListener {
            status.text = "🔴 LIVE: Cek VIP...\nJika belum VIP -> Muncul QRIS 1 Bulan Rp30.000\nMIDTRANS: ${BuildConfig.MIDTRANS_CLIENT_KEY.take(10)}...\nJika sudah VIP -> Masuk Agora Live: ${BuildConfig.AGORA_APP_ID.take(8)}..."
        }

        btnUpload.setOnClickListener {
            status.text = "📁 Upload dari galeri: pilih video -> upload ke Firebase"
        }

        root.addView(tv)
        root.addView(btnLive)
        root.addView(btnUpload)
        root.addView(status)
        setContentView(root)
    }
}
