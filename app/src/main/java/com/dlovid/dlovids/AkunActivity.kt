package com.dlovid.dlovids

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class AkunActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(40, 60, 40, 40)
        }

        val tvTitle = TextView(this).apply { text = "👤 MENU AKUN"; textSize = 20f }

        // 1. Foto bisa edit di pojok klik ada icon pensil
        val fotoRow = LinearLayout(this).apply { orientation = LinearLayout.HORIZONTAL }
        val tvFoto = TextView(this).apply { text = "📷 Foto Profil "; textSize = 16f }
        val btnEditFoto = Button(this).apply { text = "[✏️ Edit]" }
        fotoRow.addView(tvFoto)
        fotoRow.addView(btnEditFoto)

        // 2. Nama di tengah bisa di edit di pojok klik ada icon pensil
        val namaRow = LinearLayout(this).apply { orientation = LinearLayout.HORIZONTAL }
        val tvNama = TextView(this).apply { text = "Nama: User DLOVID "; textSize = 16f }
        val btnEditNama = Button(this).apply { text = "[✏️ Edit]" }
        namaRow.addView(tvNama)
        namaRow.addView(btnEditNama)

        // 3. Menu koin bisa di cairkan ke rupiah
        val btnKoin = Button(this).apply { text = "💰 Koin: 1000 -> Tukar Rupiah" }

        // 4. Dompet
        val btnDompet = Button(this).apply { text = "👛 Dompet: Rp0" }

        // 5. Penarikan uang ke dompet/bank dengan potongan 20% admin
        val btnWd = Button(this).apply { text = "💸 WD ke Wallet/Bank (Potongan 20% Admin)" }

        // 6. VIP
        val btnVip = Button(this).apply { text = "👑 VIP: Beli 1 Bulan Rp30.000 QRIS" }

        val status = TextView(this).apply { setPadding(0, 20, 0, 0) }

        btnEditFoto.setOnClickListener { status.text = "Edit foto: pilih dari galeri" }
        btnEditNama.setOnClickListener { status.text = "Edit nama tengah" }
        btnKoin.setOnClickListener { status.text = "Koin cair ke rupiah: 1000 koin = Rp10.000 (contoh)" }
        btnDompet.setOnClickListener { status.text = "Dompet: Saldo Rp0" }
        btnWd.setOnClickListener { status.text = "WD: Rp100.000 -> potongan 20% = Rp80.000 masuk bank/wallet\nFirebase Functions nanti" }
        btnVip.setOnClickListener { status.text = "VIP QRIS Midtrans 1 Bln 30rb / Tahunan\nClient: ${BuildConfig.MIDTRANS_CLIENT_KEY.take(10)}..." }

        root.addView(tvTitle)
        root.addView(fotoRow)
        root.addView(namaRow)
        root.addView(btnKoin)
        root.addView(btnDompet)
        root.addView(btnWd)
        root.addView(btnVip)
        root.addView(status)

        val scroll = ScrollView(this)
        scroll.addView(root)
        setContentView(scroll)
    }
}
