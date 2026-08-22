        // === ADMIN 2 PANEL SWITCH ===
        val prefs = getSharedPreferences("DLOVID", MODE_PRIVATE)
        val email = prefs.getString("email", "") ?: ""
        
        // Kalau email admin, tampilkan tombol switch
        if (AdminManager.isAdminEmail(email)) {
            // Buat tombol floating admin
            val adminBtn = android.widget.Button(this).apply {
                text = "ADMIN 2 PANEL"
                setBackgroundColor(android.graphics.Color.parseColor("#FFD700"))
                setOnClickListener {
                    val options = arrayOf("Masuk Panel ADMIN", "Masuk Panel USER Biasa")
                    androidx.appcompat.app.AlertDialog.Builder(this@MainActivity)
                        .setTitle("Admin Login Detected")
                        .setItems(options) { _, which ->
                            if (which == 0) {
                                // Panel ADMIN
                                try {
                                    val intent = android.content.Intent(this@MainActivity, Class.forName("com.dlovid.short.AdminActivity"))
                                    startActivity(intent)
                                } catch (e: Exception) {
                                    android.widget.Toast.makeText(this@MainActivity, "AdminActivity belum ada", android.widget.Toast.LENGTH_SHORT).show()
                                }
                            } else {
                                // Panel USER
                                android.widget.Toast.makeText(this@MainActivity, "Mode USER aktif - nonton kayak user biasa", android.widget.Toast.LENGTH_SHORT).show()
                            }
                        }
                        .show()
                }
            }
            // Tambah ke layout - kalau pakai FrameLayout
            try {
                (findViewById(android.R.id.content) as android.view.ViewGroup).addView(adminBtn)
            } catch (e: Exception) {}
        }
