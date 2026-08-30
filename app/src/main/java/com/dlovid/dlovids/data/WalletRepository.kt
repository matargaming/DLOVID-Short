package com.dlovid.dlovids.data
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FieldValue
import com.google.firebase.firestore.FirebaseFirestore
import kotlinx.coroutines.tasks.await

data class UserWallet(val coins: Long = 0, val rupiah: Long = 0, val walletBalance: Long = 0)

object WalletRepository {
    private val db = FirebaseFirestore.getInstance()
    private val auth = FirebaseAuth.getInstance()
    const val COIN_RATE = 100L
    const val ADMIN_FEE_PERCENT = 20

    suspend fun getWallet(): UserWallet {
        val uid = auth.currentUser?.uid ?: return UserWallet()
        val doc = db.collection("users").document(uid).get().await()
        return UserWallet(doc.getLong("coins")?:0, doc.getLong("rupiah")?:0, doc.getLong("walletBalance")?:0)
    }

    suspend fun exchangeCoinToRupiah(coinAmount: Long): Result<Long> {
        val uid = auth.currentUser?.uid ?: return Result.failure(Exception("Belum login"))
        return try {
            db.runTransaction { trans ->
                val ref = db.collection("users").document(uid)
                val snap = trans.get(ref)
                val currentCoins = snap.getLong("coins")?:0
                if(currentCoins < coinAmount) throw Exception("Koin tidak cukup")
                val rupiahAdd = coinAmount * COIN_RATE
                trans.update(ref, mapOf("coins" to currentCoins - coinAmount, "rupiah" to FieldValue.increment(rupiahAdd), "walletBalance" to FieldValue.increment(rupiahAdd)))
                rupiahAdd
            }.await().let { Result.success(coinAmount * COIN_RATE) }
        } catch(e: Exception) { Result.failure(e) }
    }

    suspend fun requestWithdraw(amountRupiah: Long, target: String, targetType: String): Result<String> {
        val uid = auth.currentUser?.uid ?: return Result.failure(Exception("Belum login"))
        if(amountRupiah < 10000) return Result.failure(Exception("Minimal WD Rp 10.000"))
        return try {
            val fee = amountRupiah * ADMIN_FEE_PERCENT / 100
            val receive = amountRupiah - fee
            val wdId = db.collection("withdrawals").document().id
            db.runTransaction { trans ->
                val userRef = db.collection("users").document(uid)
                val snap = trans.get(userRef)
                val balance = snap.getLong("walletBalance")?:0
                if(balance < amountRupiah) throw Exception("Saldo tidak cukup: Rp $balance")
                trans.update(userRef, "walletBalance", balance - amountRupiah)
                trans.set(db.collection("withdrawals").document(wdId), mapOf("id" to wdId, "uid" to uid, "email" to (auth.currentUser?.email?:""), "amount" to amountRupiah, "fee" to fee, "receive" to receive, "target" to target, "targetType" to targetType, "status" to "PENDING", "createdAt" to FieldValue.serverTimestamp()))
            }.await()
            Result.success(wdId)
        } catch(e: Exception) { Result.failure(e) }
    }
}
