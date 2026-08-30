package com.dlovid.dlovids

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class DramaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(20, 40, 20, 20)
        }

        // Pojok atas: VIP + Pencarian
        val topBar = LinearLayout(this).apply { orientation = LinearLayout.HORIZONTAL }
        val btnVip = Button(this).apply { text = "👑 VIP - Klik beli" }
        val btnSearch = Button(this).apply { text = "🔍 Cari video" }
        topBar.addView(btnVip)
        topBar.addView(btnSearch)

        // 1. Film campuran paling atas bisa scroll kiri-kanan dari TMDB + ADA IKLAN SELESAI EPISODE
        val tvTop = TextView(this).apply {
            text = "🎬 Film Campuran (Drakor, Dracin, Barat, India) - Scroll kiri-kanan (TMDB API)\nAda iklan selesai episode"
            textSize = 14f
        }
        val hScroll = HorizontalScrollView(this)
        val hLinear = LinearLayout(this).apply { orientation = LinearLayout.HORIZONTAL }
        for (i in 1..10) {
            val card = Button(this).apply {
                text = "Film $i"
                setOnClickListener {
                    val intent = android.content.Intent(this@DramaActivity, PlayerActivity::class.java)
                    intent.putExtra("FILM", "Film $i")
                    startActivity(intent)
                }
            }
            hLinear.addView(card)
        }
        hScroll.addView(hLinear)

        // 2. Kotak kolase film campuran dengan judul 13 kategori
        val tvKategori = TextView(this).apply {
            text = "\n📦 Kolase Kategori:"
            textSize = 18f
        }
        
        val categories = listOf(
            "MODERN", "MILIARDER", "PENGEMBANGAN DIRI", "MISKIN JADI KAYA",
            "RAHASIA", "DIREKTUR UTAMA", "KARMA", "IDENTITAS TERSEMBUNYI",
            "CEO", "CINTA", "BALAS DENDAM", "INDIA", "BARAT"
        )

        val grid = GridLayout(this).apply { columnCount = 2 }
        categories.forEach { cat ->
            val b = Button(this).apply {
                text = cat
                setOnClickListener {
                    val intent = android.content.Intent(this@DramaActivity, PlayerActivity::class.java)
                    intent.putExtra("FILM", cat)
                    startActivity(intent)
                }
            }
            grid.addView(b)
        }

        val status = TextView(this)

        btnVip.setOnClickListener {
            // 5. VIP klik buka pembelian 1 BLN 30.000 -> QRIS
            // 6. Klik icon VIP diarahkan ke menu akun
            status.text = "👑 VIP: 1 Bulan Rp30.000 / 1 Tahun Rp300.000\nQRIS Midtrans muncul -> Client: ${BuildConfig.MIDTRANS_CLIENT_KEY.take(5)}...\nNanti diarahkan ke MENU AKUN untuk beli"
        }

        btnSearch.setOnClickListener {
            // 7. Fitur pencarian video
            status.text = "🔍 Pencarian video (TMDB search) - ketik judul drama..."
        }

        root.addView(topBar)
        root.addView(tvTop)
        root.addView(hScroll)
        root.addView(tvKategori)
        root.addView(grid)
        root.addView(status)

        val scroll = ScrollView(this)
        scroll.addView(root)
        setContentView(scroll)
    }
}
