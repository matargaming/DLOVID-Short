package com.dlovid.short

import android.content.Intent
import android.os.Bundle
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity

class BonusActivity : AppCompatActivity() {

    private lateinit var aiBicara: AiBicaraD5

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // D5 full robot
        setContentView(R.layout.layout_bonus_d5)

        aiBicara = AiBicaraD5(this)
        aiBicara.mulaiBicara("Selamat datang di menu bonus bos!")

        // ============ E2 - PINDAH MENU ============
        val btnHome = findViewById<ImageView>(R.id.btnMenuHome)
        val btnShort = findViewById<ImageView>(R.id.btnMenuShort)
        val btnBonus = findViewById<ImageView>(R.id.btnMenuBonus)
        val btnProfile = findViewById<ImageView>(R.id.btnMenuProfile)

        btnHome.setOnClickListener {
            aiBicara.mulaiBicara("Pindah ke Home")
            startActivity(Intent(this, MainActivity::class.java))
            finish()
        }

        btnShort.setOnClickListener {
            aiBicara.mulaiBicara("Pindah ke Short")
            // ganti ShortActivity kalau nama activity short kamu beda
            startActivity(Intent(this, MainActivity::class.java))
        }

        btnBonus.setOnClickListener {
            aiBicara.mulaiBicara("Kamu sudah di menu bonus bos")
        }

        btnProfile.setOnClickListener {
            aiBicara.mulaiBicara("Pindah ke Profile")
            // startActivity(Intent(this, ProfileActivity::class.java))
        }
    }

    override fun onDestroy() {
        aiBicara.stopBicara()
        super.onDestroy()
    }
}
