package com.dlovids.short.admin

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.dlovids.short.core.Secrets
import com.google.firebase.firestore.FirebaseFirestore

@Composable
fun AdminDramaDashboard(currentEmail: String) {

    // REAL: Cek admin dari ADMIN_EMAIL secret
    if (currentEmail != Secrets.ADMIN_EMAIL) {
        Text("Akses ditolak: ${currentEmail} bukan admin", color = Color.Red)
        return
    }

    val db = FirebaseFirestore.getInstance()
    var dramaList by remember { mutableStateOf<List<Map<String, Any>>>(emptyList()) }
    var titleInput by remember { mutableStateOf("") }
    var videoUrl by remember { mutableStateOf("") }

    // REAL: Load drama dari Firestore
    LaunchedEffect(Unit) {
        db.collection("dramas").addSnapshotListener { snap, _ ->
            dramaList = snap?.documents?.map { it.data ?: emptyMap() } ?: emptyList()
        }
    }

    Column(Modifier.fillMaxSize().background(Color.Black).padding(16.dp)) {
        Text("Admin Dashboard REAL - ${Secrets.ADMIN_EMAIL}", color = Color.White)

        Spacer(Modifier.height(12.dp))
        
        // Verifikasi 3 Key Admin
        Text("Keys: ${Secrets.ADMIN_KEY_1.take(5)}*** | ${Secrets.ADMIN_KEY_2.take(5)}*** | ${Secrets.ADMIN_KEY_3.take(5)}***", color = Color.Gray)

        OutlinedTextField(value = titleInput, onValueChange = { titleInput = it }, label = { Text("Judul Drama") })
        OutlinedTextField(value = videoUrl, onValueChange = { videoUrl = it }, label = { Text("Video URL") })

        Button(onClick = {
            // REAL: Simpan ke Firestore
            db.collection("dramas").add(mapOf("title" to titleInput, "videoUrl" to videoUrl, "created" to System.currentTimeMillis()))
            titleInput = ""; videoUrl = ""
        }) { Text("Upload Drama REAL") }

        LazyColumn {
            items(dramaList) { drama ->
                Card(Modifier.padding(4.dp)) {
                    Text(drama["title"].toString(), modifier = Modifier.padding(8.dp))
                }
            }
        }
    }
}
