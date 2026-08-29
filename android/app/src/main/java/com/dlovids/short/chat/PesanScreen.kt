package com.dlovids.short.pesan

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.AsyncImage
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.Query

data class ChatUser(val uid: String, val nama: String, val foto: String, val lastChat: String, val time: Long)

@Composable
fun PesanScreen(onOpenChat: (String) -> Unit) {
    val db = FirebaseFirestore.getInstance()
    val myUid = FirebaseAuth.getInstance().currentUser?.uid ?: ""

    var chatList by remember { mutableStateOf<List<ChatUser>>(emptyList()) }

    // REAL: Ambil daftar chat dari Firestore collection chats
    LaunchedEffect(Unit) {
        db.collection("chats")
            .whereArrayContains("members", myUid)
            .orderBy("lastTime", Query.Direction.DESCENDING)
            .addSnapshotListener { snap, _ ->
                chatList = snap?.documents?.map { doc ->
                    val members = doc.get("members") as List<String>
                    val otherUid = members.firstOrNull { it != myUid } ?: ""
                    ChatUser(
                        uid = otherUid,
                        nama = doc.getString("otherNama") ?: "User",
                        foto = doc.getString("otherFoto") ?: "",
                        lastChat = doc.getString("lastMessage") ?: "",
                        time = doc.getLong("lastTime") ?: 0L
                    )
                } ?: emptyList()
            }
    }

    Column(
        Modifier.fillMaxSize().background(Color(0xFF0A0A0A)).padding(16.dp)
    ) {
        Text("Pesan", color = Color.White, fontSize = 22.sp)
        Spacer(Modifier.height(16.dp))

        LazyColumn(verticalArrangement = Arrangement.spacedBy(12.dp)) {
            items(chatList) { user ->
                Card(
                    modifier = Modifier.fillMaxWidth().clickable { onOpenChat(user.uid) },
                    shape = RoundedCornerShape(16.dp),
                    colors = CardDefaults.cardColors(Color(0xFF1E1E1E))
                ) {
                    Row(Modifier.padding(12.dp), verticalAlignment = Alignment.CenterVertically) {
                        AsyncImage(
                            model = user.foto.ifEmpty { "https://i.pravatar.cc/150?u=${user.uid}" },
                            contentDescription = "foto",
                            modifier = Modifier.size(50.dp).clip(CircleShape)
                        )
                        Spacer(Modifier.width(12.dp))
                        Column(Modifier.weight(1f)) {
                            Text(user.nama, color = Color.White, fontSize = 16.sp)
                            Text(user.lastChat, color = Color.Gray, fontSize = 13.sp, maxLines = 1)
                        }
                    }
                }
            }
        }

        if (chatList.isEmpty()) {
            Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                Text("Belum ada pesan", color = Color.Gray)
            }
        }
    }
}
