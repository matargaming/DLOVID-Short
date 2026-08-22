package com.dlovid.short

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class BonusActivity : AppCompatActivity() {

    private lateinit var aiBicara: AiBicaraD5
    private var totalTeman = 0
    private var totalPoin = 15500

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.layout_bonus_d4) // Ganti ke layout_bonus_d5 kalo mau tes robot full

        // D4 VIEW
        val txtTotalTeman = findViewById<TextView>(R.id.txtTotalTemanD4)
        val txtTotalPoin = findViewById<TextView>(R.id.txtTotalPoinD4)
        val txtAiBicara = findViewById<TextView>(R.id.txtAiBicaraD4)
        val mataKiri = findViewById<TextView>(R.id.mataKiriD4)
        val mataKanan = findViewById<TextView>(R.id.mataKananD4)
        val inputId = findViewById<EditText>(R.id.inputNoHp)
        val btnProses = findViewById<Button>(R.id.btnProsesCair)
        val btnA = findViewById<Button>(R.id.btnCairDana)
        val btnB = findViewById<Button>(R.id.btnCairOvo)
        val btnC = findViewById<Button>(R.id.btnCairGopay)

        // INIT AI D5
        aiBicara = AiBicaraD5(mataKiri, mataKanan, txtAiBicara)

        // LOAD DATA
        totalTeman = 3 // contoh dari database
        txtTotalTeman.text = "$totalTeman"
        txtTotalPoin.text = "Poin: $totalPoin"

        // AI BICARA OTOMATIS
        txtAiBicara.postDelayed({
            aiBicara.bicaraBonusD4(totalTeman, totalPoin)
        }, 1000)

        // PILIHAN A/B/C
        btnA.setOnClickListener { 
            aiBicara.bicara("Opsi A dipilih. Masukkan ID kamu ya!")
            inputId.hint = "Input ID Opsi A"
        }
        btnB.setOnClickListener { 
            aiBicara.bicara("Opsi B dipilih. Lanjut bos!")
            inputId.hint = "Input ID Opsi B"
        }
        btnC.setOnClickListener { 
            aiBicara.bicara("Opsi C dipilih. Gas!")
            inputId.hint = "Input ID Opsi C"
        }

        // PROSES
        btnProses.setOnClickListener {
            val id = inputId.text.toString()
            if (id.isEmpty()) {
                aiBicara.bicara("Isi ID dulu bos!")
                Toast.makeText(this, "Isi ID dulu", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            if (totalPoin < 10000) {
                aiBicara.bicara("Poin belum cukup. Ajak teman lagi yuk!")
                Toast.makeText(this, "Poin min 10000", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            // SUKSES
            aiBicara.bicara("Mantap! Proses berhasil. ID $id akan diproses 1x24 jam. Poin VIP aktif!")
            Toast.makeText(this, "PROSES SUKSES: $id", Toast.LENGTH_LONG).show()
            
            // Simulasi update poin
            totalPoin -= 10000
            txtTotalPoin.text = "Poin: $totalPoin"
        }
    }

    override fun onDestroy() {
        aiBicara.destroy()
        super.onDestroy()
    }
}
