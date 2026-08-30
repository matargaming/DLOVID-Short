package com.dlovid.dlovids

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class BerandaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(20, 40, 20, 20)
        }
        val tv = TextView(this).apply {
            text = "🏠 BERANDA - TikTok Style\n\nLive ada di beranda seperti TikTok (upload konten kreator)\nScroll vertikal video\n\n[Ini nanti list video kreator + tombol live]"
            textSize = 16f
        }
        val btnPlus = Button(this).apply {
            text = "➕ Klik Plus (Live/Upload)"
            setOnClickListener {
                startActivity(android.content.Intent(this@BerandaActivity, PlusActivity::class.java))
            }
        }
        val btnAkun = Button(this).apply {
            text = "👤 Ke Menu Akun"
            setOnClickListener {
                startActivity(android.content.Intent(this@BerandaActivity, AkunActivity::class.java))
            }
        }
        root.addView(tv)
        root.addView(btnPlus)
        root.addView(btnAkun)
        setContentView(root)
    }
}
