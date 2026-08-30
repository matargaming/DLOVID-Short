package com.dlovid.dlovids

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class PlayerActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val film = intent.getStringExtra("FILM") ?: "Drama"

        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(20, 100, 20, 20)
        }

        val tv = TextView(this).apply {
            text = "▶️ FULLSCREEN VERTIKAL\n$film\n\n" +
                    "- Film terisi otomatis online setiap Minggu diganti update trend diatur AI (TMDB)\n" +
                    "- AdMob Interstitial selesai episode\n" +
                    "- VIP bebas milih episode apa aja"
            textSize = 16f
        }

        // 8. Kanan paling bawah tombol ganti episode
        val btnGantiEp = Button(this).apply {
            text = "Kanan bawah: Ganti Episode ➡️"
        }

        val btnIklan = Button(this).apply {
            text = "Selesai Episode -> Iklan AdMob: ${BuildConfig.ADMOB_INTER_ID.take(10)}..."
        }

        val status = TextView(this)

        btnGantiEp.setOnClickListener {
            status.text = "Ganti episode: ${film} Ep 1 -> Ep 2 -> Ep 3\nVIP bebas milih episode apa aja"
        }

        btnIklan.setOnClickListener {
            status.text = "Iklan AdMob tayang selesai episode..."
        }

        root.addView(tv)
        root.addView(btnGantiEp)
        root.addView(btnIklan)
        root.addView(status)

        setContentView(root)
    }
}
