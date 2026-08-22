package com.dlovid.short

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.midtrans.sdk.SdkUIFlowBuilder

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // INIT MIDTRANS QRIS 15K
        SdkUIFlowBuilder.init()
            .setClientKey(MidtransConfig.CLIENT_KEY)
            .setContext(this)
            .setMerchantBaseUrl("https://app.sandbox.midtrans.com/snap/v1/")
            .enableLog(true)
            .buildSDK()

        // Tombol ke Bonus VIP
        try {
            val btnBonus = findViewById<Button>(R.id.btnBonus)
            btnBonus.setOnClickListener {
                startActivity(Intent(this, BonusActivity::class.java))
            }
        } catch (e: Exception) {
        }
    }
}
