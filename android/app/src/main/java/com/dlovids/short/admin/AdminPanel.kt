package com.dlovids.short.admin

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.dlovids.short.core.Secrets
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.Query
import kotlinx.coroutines.tasks.await

data class LiveUser(val uid: String, val nama: String, val title: String, val viewers: Int)
data class DramaTrending(val id: Int, val title: String, val poster: String, val views: Int)
data class AdLog(val userId: String, val count: Int, val date: String)

@Composable
fun AdminPanel() {
    val db = FirebaseFirestore.getInstance()

    var liveUsers by remember { mutableStateOf<List<LiveUser>>(emptyList()) }
    var trending by remember { mutableStateOf<List<DramaTrending>>(emptyList()) }
    var adLogs by remember { mutableStateOf<List<AdLog>>(emptyList()) }
    var totalIncome by remember { mutableStateOf(0L) }
    var totalWdFee by remember { mutableStateOf(0L) }

    // REAL DATA LOAD
    LaunchedEffect(Unit) {
        // 1. Live users yang sedang live
        db.collection("live_now").addSnapshotListener { snap, _ ->
            liveUsers = snap?.documents?.map {
                LiveUser(it.id, it.getString("nama") ?: "", it.getString("title") ?: "", it.getLong("viewers")?.toInt() ?: 0)
            } ?: emptyList()
        }
        // 2. Iklan ditonton
        db.collection("ad_logs").orderBy("date", Query.Direction.DESCENDING).limit(50).addSnapshotListener { snap, _ ->
            adLogs = snap?.documents?.map {
                AdLog(it.getString("userId") ?: "", it.getLong("count")?.toInt() ?: 0, it.getString("date") ?: "")
            } ?: emptyList()
        }
        // 3. Pendapatan & WD Fee 20%
        db.collection("wd_logs").get().addOnSuccessListener { snap ->
            var total = 0L
            var fee = 0L
            snap.documents.forEach {
                val amount
