package com.dlovid.dlovids

import android.os.Bundle
import android.text.InputType
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    
    // Secrets dari GitHub Secrets -> BuildConfig
    private val ADMIN_EMAIL = BuildConfig.ADMIN_EMAIL
    private val KEY1 = BuildConfig.ADMIN_KEY_1
    private val KEY2 = BuildConfig.ADMIN_KEY_2
    private val KEY3 = BuildConfig.ADMIN_KEY_3

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(60, 100, 60, 60)
        }

        // 1. Logo DLOVID short diatas
        val logo = TextView(this).apply {
            text = "DLOVID\nshort\nDrama Gold"
            textSize = 32f
            textAlignment = TextView.TEXT_ALIGNMENT_CENTER
            setPadding(0, 0, 0, 40)
        }

        // 2. Email/No HP
        val etEmail = EditText(this).apply {
            hint = "Email / No HP"
        }

        // 3. Sandi + intip 👁️
        val etSandi = EditText(this).apply {
            hint = "Sandi"
            inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
        }

        // 4. Confirm + intip
        val etConfirm = EditText(this).apply {
            hint = "Confirm Sandi"
            inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
        }

        val cbIntip = CheckBox(this).apply {
            text = "Intip sandi 👁️"
            setOnCheckedChangeListener { _, isChecked ->
                val type = if (isChecked) InputType.TYPE_CLASS_TEXT 
                           else InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
                etSandi.inputType = type
                etConfirm.inputType = type
            }
        }

        // 5. OTP via HP/Email
        val btnOtp = Button(this).apply {
            text = "Kirim OTP via HP/Email"
        }

        val btnLogin = Button(this).apply {
            text = "LOGIN PENGGUNA"
        }

        val btnAdmin = Button(this).apply {
            text = "LOGIN ADMIN"
        }

        val status = TextView(this).apply {
            textSize = 14f
            setPadding(0, 20, 0, 0)
        }

        // --- PANEL ADMIN VIEW (awalnya GONE) ---
        val adminPanel = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            visibility = LinearLayout.GONE
            setPadding(0, 30, 0, 0)
        }
        val tvAdminTitle = TextView(this).apply { text = "PANEL ADMIN - Masukkan 2 sandi lagi:"; textSize = 16f }
        val etKey2 = EditText(this).apply { hint = "Sandi ADMIN_KEY_2" }
        val etKey3 = EditText(this).apply { hint = "Sandi ADMIN_KEY_3" }
        val btnMasukAdmin = Button(this).apply { text = "Masuk Panel Admin" }
        adminPanel.addView(tvAdminTitle)
        adminPanel.addView(etKey2)
        adminPanel.addView(etKey3)
        adminPanel.addView(btnMasukAdmin)

        // Logic
        btnOtp.setOnClickListener {
            status.text = "OTP terkirim ke ${etEmail.text} (Firebase OTP - nanti aktif setelah Firebase jadi)"
        }

        btnLogin.setOnClickListener {
            val email = etEmail.text.toString()
            val sandi = etSandi.text.toString()
            val confirm = etConfirm.text.toString()

            if (email.isEmpty() || sandi.isEmpty()) {
                status.text = "❌ Email/HP & Sandi wajib isi!"
                return@setOnClickListener
            }
            if (sandi != confirm) {
                status.text = "❌ Confirm sandi tidak cocok! APK menolak."
                return@setOnClickListener
            }
            if (sandi.length < 6) {
                status.text = "❌ Sandi minimal 6 karakter, ditolak!"
                return@setOnClickListener
            }
            status.text = "✅ Login pengguna berhasil! Masuk ke MENU DRAMA..."
            startActivity(android.content.Intent(this@MainActivity, DramaActivity::class.java))
        }

        btnAdmin.setOnClickListener {
            val email = etEmail.text.toString()
            val sandi = etSandi.text.toString()
            if (email != ADMIN_EMAIL) {
                status.text = "❌ Bukan Gmail admin! Harus: $ADMIN_EMAIL"
                return@setOnClickListener
            }
            if (sandi != KEY1) {
                status.text = "❌ ADMIN_KEY_1 salah! Ditolak."
                return@setOnClickListener
            }
            status.text = "✅ KEY_1 Benar! Masukkan 2 sandi lagi di bawah..."
            adminPanel.visibility = LinearLayout.VISIBLE
        }

        btnMasukAdmin.setOnClickListener {
            if (etKey2.text.toString() != KEY2) {
                status.text = "❌ ADMIN_KEY_2 salah!"
                return@setOnClickListener
            }
            if (etKey3.text.toString() != KEY3) {
                status.text = "❌ ADMIN_KEY_3 salah!"
                return@setOnClickListener
            }
            status.text = "🎉 ADMIN LOGIN SUKSES! Panel: Kotak live iklan, trending TMDB, saran live/block"
        }

        root.addView(logo)
        root.addView(etEmail)
        root.addView(etSandi)
        root.addView(etConfirm)
        root.addView(cbIntip)
        root.addView(btnOtp)
        root.addView(btnLogin)
        root.addView(btnAdmin)
        root.addView(status)
        root.addView(adminPanel)

        val scroll = ScrollView(this)
        scroll.addView(root)
        setContentView(scroll)
    }
}
