package com.dlovid.dlovids

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class PesanActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(40, 60, 40, 40)
        }
        val tv = TextView(this).apply {
            text = "💬 MENU PESAN\n\nChat user ke user\nNotifikasi live\nSaran live admin"
            textSize = 16f
        }
        root.addView(tv)
        setContentView(root)
    }
}
