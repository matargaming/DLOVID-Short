package com.dlovids.short.plus

import android.app.Activity
import android.net.Uri
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import com.dlovids.short.core.Secrets
import com.dlovids.short.live.AgoraManager
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.storage.FirebaseStorage

@Composable
fun PlusMenu(onClose: () -> Unit) {
    val context = LocalContext.current
    val activity = context as Activity
    val db = FirebaseFirestore.getInstance()
    val storage = FirebaseStorage.getInstance()
    val uid = FirebaseAuth.getInstance().currentUser?.uid ?: ""
    val nama = FirebaseAuth.getInstance().currentUser?.displayName ?: "User"

    var uploading by remember { mutableStateOf(false) }
    var showLiveDialog by remember { mutableStateOf(false) }

    val videoPicker = rememberLauncherForActivityResult(ActivityResultContracts.GetContent()) { uri: Uri? ->
        uri?.let {
            uploading = true
            val ref = storage.reference.child("dramas/${uid}_${System.currentTimeMillis()}.mp4")
            ref.putFile(it).addOnSuccessListener {
                ref.downloadUrl.addOnSuccessListener { url ->
                    // REAL: Simpan ke Firestore
                    db.collection("dramas").add(
                        mapOf(
                            "title" to "Drama by $nama",
                            "videoUrl" to url.toString(),
                            "uid" to uid,
                            "created" to System.currentTimeMillis()
                        )
                    )
                    uploading = false
                    onClose()
                }
            }
        }
    }

    Box(
        Modifier.fillMaxSize().background(Color(0x99000000)),
        contentAlignment = Alignment.BottomCenter
    ) {
        Card(
            Modifier.fillMaxWidth(),
            shape = RoundedCornerShape(topStart = 20.dp, topEnd = 20.dp),
            colors = CardDefaults.cardColors(Color(0xFF1E1E1E))
        ) {
            Column(Modifier.padding(20.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                Text("Upload Drama / Live", color = Color.White)

                Button(onClick = { videoPicker.launch("video/*") }, Modifier.fillMaxWidth()) {
                    Text(if (uploading) "Uploading REAL ke ${Secrets.FIREBASE_PROJECT_ID}..." else "Upload Video Drama")
                }

                Button(
                    onClick = { showLiveDialog = true },
                    Modifier.fillMaxWidth(),
                    colors = ButtonDefaults.buttonColors(Color.Red)
                ) {
                    Text("Mulai Live Agora (AppID: ${Secrets.AGORA_APP_ID.take(4)}***)")
                }

                Button(onClick = onClose, Modifier.fillMaxWidth(), colors = ButtonDefaults.buttonColors(Color.Gray)) {
                    Text("Batal")
                }
            }
        }
    }

    if (showLiveDialog) {
        var liveTitle by remember { mutableStateOf("") }
        AlertDialog(
            onDismissRequest = { showLiveDialog = false },
            title = { Text("Live Streaming REAL") },
            text = {
                Column {
                    Text("Channel akan dibuat dengan Agora REAL ID")
                    TextField(value = liveTitle, onValueChange = { liveTitle = it }, placeholder = { Text("Judul Live") })
                }
            },
            confirmButton = {
                Button(onClick = {
                    // REAL: Start Live Agora
                    AgoraManager.init(context)
                    AgoraManager.startLive("live_$uid", uid, liveTitle, nama)
                    showLiveDialog = false
                    onClose()
                }) { Text("Go Live") }
            },
            dismissButton = { Button(onClick = { showLiveDialog = false }) { Text("Batal") } }
        )
    }
}
