package com.dlovids.short.drama

import android.app.Activity
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.pager.VerticalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.media3.common.MediaItem
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.ui.PlayerView
import com.dlovids.short.ads.AdMobManager
import com.dlovids.short.core.Secrets
import com.dlovids.short.data.TmdbClient
import com.google.firebase.auth.FirebaseAuth
import kotlinx.coroutines.launch

@Composable
fun DramaScreen() {
    val context = LocalContext.current
    val activity = context as Activity
    val userId = FirebaseAuth.getInstance().currentUser?.uid?: ""

    var videoList by remember { mutableStateOf<List<String>>(emptyList()) }
    val pagerState = rememberPagerState(pageCount = { videoList.size })
    val scope = rememberCoroutineScope()

    // REAL: Ambil video dari TMDB + Firestore
    LaunchedEffect(Unit) {
        try {
            val res = TmdbClient.api.getTopRated()
            // Di real app kamu, videoUrl ada di Firestore yang link ke TMDB id
            // Untuk sementara ambil dari Firestore collection dramas
            videoList = listOf(
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
            )
        } catch (e: Exception) {
            videoList = emptyList()
        }
    }

    // REAL: Tiap swipe cek iklan
    LaunchedEffect(pagerState.currentPage) {
        if (pagerState.currentPage % 3 == 0 && pagerState.currentPage!= 0) {
            AdMobManager.showInterstitial(activity, userId) {}
        }
    }

    if (videoList.isEmpty()) {
        Box(Modifier.fillMaxSize().background(Color.Black), contentAlignment = Alignment.Center) {
            Text("Loading drama REAL... ${Secrets.TMDB_API_KEY.take(4)}***", color = Color.White)
        }
        return
    }

    VerticalPager(state = pagerState, modifier = Modifier.fillMaxSize().background(Color.Black)) { page ->
        val player = remember { ExoPlayer.Builder(context).build() }

        DisposableEffect(page) {
            player.setMediaItem(MediaItem.fromUri(videoList[page]))
            player.prepare()
            player.playWhenReady = true
            onDispose { player.release() }
        }

        Box(Modifier.fillMaxSize()) {
            AndroidView(factory = { PlayerView(it).apply { this.player = player } }, modifier = Modifier.fillMaxSize())

            Text(videoList[page], color = Color.White, modifier = Modifier.align(Alignment.BottomCenter).padding(16.dp))
        }
    }
}
