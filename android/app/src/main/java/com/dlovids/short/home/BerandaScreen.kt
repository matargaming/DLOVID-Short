package com.dlovids.short.home

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.AsyncImage
import com.dlovids.short.core.Secrets
import com.dlovids.short.data.TmdbClient
import com.dlovids.short.data.TmdbMovie
import com.google.firebase.firestore.FirebaseFirestore
import kotlinx.coroutines.launch

@Composable
fun BerandaScreen(onOpenDrama: (Int) -> Unit) {
    val scope = rememberCoroutineScope()
    var popular by remember { mutableStateOf<List<TmdbMovie>>(emptyList()) }
    var myDramas by remember { mutableStateOf<List<Map<String, Any>>>(emptyList()) }

    // REAL: Load dari TMDB pakai secret REAL
    LaunchedEffect(Unit) {
        try {
            popular = TmdbClient.api.getPopular().results
        } catch (e: Exception) {}
        // REAL: Load drama upload admin dari Firestore
        FirebaseFirestore.getInstance().collection("dramas")
            .addSnapshotListener { snap, _ ->
                myDramas = snap?.documents?.map { it.data?: emptyMap() }?: emptyList()
            }
    }

    Column(
        Modifier.fillMaxSize().background(Color(0xFF0A0A0A)).verticalScroll(rememberScrollState()).padding(16.dp)
    ) {
        Text("DLOVIDS SHORT - REAL ${Secrets.FIREBASE_PROJECT_ID}", color = Color.White, fontSize = 20.sp)

        Spacer(Modifier.height(16.dp))
        Text("Populer di TMDB (KEY: ${Secrets.TMDB_API_KEY.take(4)}***)", color = Color.White)

        LazyRow(horizontalArrangement = Arrangement.spacedBy(10.dp)) {
            items(popular) { movie ->
                Card(
                    Modifier.width(130.dp).clickable { onOpenDrama(movie.id) },
                    shape = RoundedCornerShape(12.dp)
                ) {
                    Column {
                        AsyncImage(
                            model = TmdbClient.getImageUrl(movie.poster_path),
                            contentDescription = "poster",
                            contentScale = ContentScale.Crop,
                            modifier = Modifier.height(180.dp).clip(RoundedCornerShape(12.dp))
                        )
                        Text(movie.title, maxLines = 1, modifier = Modifier.padding(6.dp))
                    }
                }
            }
        }

        Spacer(Modifier.height(20.dp))
        Text("Drama Upload Admin", color = Color.White)

        myDramas.forEach { d ->
            Card(Modifier.fillMaxWidth().padding(vertical = 6.dp).clickable {}) {
                Text(d["title"].toString(), modifier = Modifier.padding(12.dp))
            }
        }
    }
}
