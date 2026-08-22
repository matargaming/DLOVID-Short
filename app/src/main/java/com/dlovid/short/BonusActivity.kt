package com.dlovid.short

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.midtrans.sdk.corekit.core.MidtransSDK
import com.midtrans.sdk.corekit.core.TransactionRequest
import com.midtrans.sdk.corekit.models.CustomerDetails
import com.midtrans.sdk.corekit.models.ItemDetails

class BonusActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_bonus)

        // AI Bicara D5
        val aiD5 = AiBicaraD5(this)
        aiD5.speakBonusIntro()

        // Tombol VIP 15K QRIS
        val btnVip = findViewById<Button>(R.id.btnVip)
        btnVip.setOnClickListener {
            startVipPayment()
        }

        // Check VIP
        VipManager.checkVipStatus { isVip, until ->
            if(isVip) {
                Toast.makeText(this, "Kamu VIP sampai $until", Toast.LENGTH_LONG).show()
            }
        }
    }

    private fun startVipPayment() {
        val orderId = "ORDER-${System.currentTimeMillis()}"
        val transactionRequest = TransactionRequest(orderId, 15000.0)
        transactionRequest.customerDetails = CustomerDetails().apply {
            customerIdentifier = "user-dlovid"
        }
        transactionRequest.itemDetails = arrayListOf(
            ItemDetails("VIP-1", 15000.0, 1, "VIP 30 Hari DLOVID")
        )
        MidtransSDK.getInstance().transactionRequest = transactionRequest
        MidtransSDK.getInstance().startPaymentUiFlow(this)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(resultCode == RESULT_OK) {
            VipManager.setVipAfterPayment()
            Toast.makeText(this, "VIP Aktif! Bonus D5 terbuka 50 dukungan!", Toast.LENGTH_LONG).show()
        }
    }
}
