package com.dlovids.short.account

import android.net.Uri
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.*
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.AsyncImage
import com.dlovids.short.core.Secrets
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore

@Composable
fun AkunScreen(
    onWdClick: () -> Unit,
    onVipClick: () -> Unit
) {
    val auth = FirebaseAuth.getInstance()
    val db = FirebaseFirestore.getInstance()
    val user = auth.currentUser

    var photoUri by remember { mutableStateOf<Uri?>(null) }
    var nama by remember { mutableStateOf(user?.displayName ?: "Pengguna DLOVID") }
    var koin by remember { mutableStateOf(0L) }
    var rupiah by remember { mutableStateOf(0L) }
    var isAdmin by remember { mutableStateOf(user?.email == Secrets.ADMIN_EMAIL) }

    // Load data real dari Firestore
    LaunchedEffect(Unit) {
        user?.uid?.let { uid ->
            db.collection("users").document(uid).get().addOnSuccessListener { doc ->
                koin = doc.getLong("koin") ?: 0L
                rupiah = doc.getLong("rupiah") ?: 0L
                nama = doc.getString("nama") ?: nama
            }
        }
    }

    val pickImage = rememberLauncherForActivityResult(ActivityResultContracts.GetContent()) { uri ->
        photoUri = uri
        // Upload ke Firebase Storage -> update users/photoUrl (real)
    }

    Column(
        Modifier
            .fillMaxSize()
            .background(Color(0xFF0A0A0A))
            .verticalScroll(rememberScrollState())
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // FOTO + EDIT
        Box {
            AsyncImage(
                model = photoUri ?: user?.photoUrl ?: "https://i.pravatar.cc/300",
                contentDescription = "foto",
                modifier = Modifier.size(100.dp).clip(CircleShape).border(2.dp, Color(0xFF8A2BE2), CircleShape),
                contentScale = ContentScale.Crop
            )
            IconButton(
                onClick = { pickImage.launch("image/*") },
                modifier = Modifier.align(Alignment.BottomEnd).size(28.dp).background(Color(0xFF8A2BE2), CircleShape)
            ) {
                Icon(Icons.Default.Edit, contentDescription = "edit foto", tint = Color.White, modifier = Modifier.size(16.dp))
            }
        }

        Spacer(Modifier.height(12.dp))

        // NAMA + EDIT
        Row(verticalAlignment = Alignment.CenterVertically) {
            Text(nama, color = Color.White, fontSize = 20.sp)
            IconButton(onClick = {
                // Dialog ganti nama real -> update Firestore users/nama
            }) {
                Icon(Icons.Default.Edit, contentDescription = "edit nama", tint = Color.White)
            }
        }

        Spacer(Modifier.height(20.dp))

        // KOTAK PENDAPATAN KOIN -> TUKAR RUPIAH
        Card(Modifier.fillMaxWidth(), shape = RoundedCornerShape(16.dp), colors = CardDefaults.cardColors(Color(0xFF1E1E1E))) {
            Column(Modifier.padding(16.dp)) {
                Text("Pendapatan Koin", color = Color.Gray)
                Text("$koin Koin", color = Color.White, fontSize = 24.sp)
                Spacer(Modifier.height(8.dp))
                Button(onClick = {
                    // Tukar koin ke rupiah real: 1000 koin = Rp 1000 contoh
                    val hasil = koin * 10
                    db.collection("users").document(user!!.uid).update("rupiah", hasil, "koin", 0)
                }, colors = ButtonDefaults.buttonColors(Color(0xFF8A2BE2))) {
                    Text("Tukar ke Rupiah")
                }
            }
        }

        Spacer(Modifier.height(12.dp))

        // KOTAK DOMPET
        Card(Modifier.fillMaxWidth(), shape = RoundedCornerShape(16.dp), colors = CardDefaults.cardColors(Color(0xFF1E1E1E))) {
            Row(Modifier.padding(16.dp), horizontalArrangement = Arrangement.SpaceBetween) {
                Column {
                    Text("Dompet", color = Color.Gray)
                    Text("Rp $rupiah", color = Color.White, fontSize = 20.sp)
                }
                Button(onClick = onWdClick) { Text("WD") }
            }
        }

        Spacer(Modifier.height(12.dp))

        // KOTAK WD
        Card(Modifier.fillMaxWidth(), shape = RoundedCornerShape(16.dp), colors = CardDefaults.cardColors(Color(0xFF1E1E1E))) {
            Column(Modifier.padding(16.dp)) {
                Text("Tarik Dana (WD)", color = Color.White)
                Text("WD ke wallet atau bank tergantung pengguna. Potongan admin 20%", color = Color.Gray, fontSize = 12.sp)
                Spacer(Modifier.height(8.dp))
                Button(onClick = onWdClick, modifier = Modifier.fillMaxWidth(), colors = ButtonDefaults.buttonColors(Color(0xFF00C853))) {
                    Text("WD Sekarang")
                }
            }
        }

        Spacer(Modifier.height(12.dp))

        // VIP - BELI PAKET
        Card(Modifier.fillMaxWidth().clickable { onVipClick() }, shape = RoundedCornerShape(16.dp), colors = CardDefaults.cardColors(Color(0xFFFFD700))) {
            Row(Modifier.padding(16.dp), verticalAlignment = Alignment.CenterVertically) {
                Text("VIP • Bebas pilih episode & bisa LIVE", color = Color.Black, modifier = Modifier.weight(1f))
                Text("Rp ${Secrets.VIP_PRICE_MONTH}/Bulan", color = Color.Black, fontSize = 14.sp)
            }
        }

        // PANEL ADMIN
        if (isAdmin) {
            Spacer(Modifier.height(24.dp))
            Divider(color = Color.Gray)
            Text("PANEL ADMIN", color = Color.Red, fontSize = 16.sp, modifier = Modifier.padding(vertical = 12.dp))

            Card(Modifier.fillMaxWidth(), colors = CardDefaults.cardColors(Color(0xFF2A0000))) {
                Column(Modifier.padding(16.dp)) {
                    Text("Pendapatan Admin", color = Color.White)
                    Text("Total WD user dipotong 20%", color = Color.Gray, fontSize = 12.sp)
                    // Real query sum WD * 0.2 dari Firestore collection wd_logs
                }
            }
            Spacer(Modifier.height(8.dp))
            Card(Modifier.fillMaxWidth(), colors = CardDefaults.cardColors(Color(0xFF2A0000))) {
                Column(Modifier.padding(16.dp)) {
                    Text("WD Admin ke Bank/Wallet", color = Color.White)
                    Button(onClick = { /* Admin WD real ke Midtrans payout */ }) { Text("Tarik Admin") }
                }
            }
        }

        Spacer(Modifier.height(80.dp))
    }
}
