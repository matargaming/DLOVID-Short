package com.dlovid.short

import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.auth.FirebaseAuth

object VipManager {
    fun checkVipStatus(onResult: (Boolean, Long) -> Unit) {
        val uid = FirebaseAuth.getInstance().currentUser?.uid ?: return
        FirebaseFirestore.getInstance().collection("users").document(uid).get()
            .addOnSuccessListener { doc ->
                val isVip = doc.getBoolean("isVip") ?: false
                val vipUntil = doc.getLong("vipUntil") ?: 0L
                onResult(isVip && vipUntil > System.currentTimeMillis(), vipUntil)
            }
    }
    
    fun setVipAfterPayment() {
        val uid = FirebaseAuth.getInstance().currentUser?.uid ?: return
        val until = System.currentTimeMillis() + 30L * 24 * 60 * 60 * 1000
        val data = mapOf(
            "isVip" to true,
            "vipUntil" to until,
            "vipPrice" to 15000
        )
        FirebaseFirestore.getInstance().collection("users").document(uid).update(data)
    }
}
