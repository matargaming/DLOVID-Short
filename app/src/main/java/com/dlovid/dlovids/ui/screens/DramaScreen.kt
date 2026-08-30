package com.dlovid.dlovids.ui.screens

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.grid.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.dlovid.dlovids.BuildConfig
import com.dlovid.dlovids.data.DramaCategories
import com.dlovid.dlovids.data.TmdbApi
import com.dlovid.dlovids.data.TmdbMovie
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DramaScreen(nav: NavController) {
    var movies by remember { mutableStateOf<List<TmdbMovie>>(emptyList()) }

    LaunchedEffect(Unit) {
        try {
            val retrofit = Retrofit.Builder().baseUrl("https://api.themoviedb.org/3/").addConverterFactory(GsonConverterFactory.create()).build()
            val api = retrofit.create(TmdbApi::class.java)
            if(BuildConfig.TMDB_API_KEY.isNotEmpty()){
                val res = api.getTrending(BuildConfig.TMDB_API_KEY)
                movies = res.results
            }
        } catch(e: Exception) { }
    }

    Scaffold(topBar={
        TopAppBar(title={Text("Drama")}, actions={
            IconButton({}){ Text("S") }
            IconButton({ nav.navigate("vip_purchase") }){ Text("VIP") }
        })
    }) { pad ->
        Column(Modifier.padding(pad)) {
            LazyRow(contentPadding=PaddingValues(12.dp), horizontalArrangement=Arrangement.spacedBy(12.dp)) {
                items(movies.size) { i ->
                    val m = movies[i]
                    Card(Modifier.width(140.dp).height(200.dp).clickable{ nav.navigate("drama_player/${m.id}") }) {
                        Box(Modifier.fillMaxSize()) { Text(m.title, modifier=Modifier.padding(8.dp)) }
                    }
                }
            }
            LazyVerticalGrid(columns=GridCells.Fixed(2), contentPadding=PaddingValues(12.dp), verticalArrangement=Arrangement.spacedBy(12.dp), horizontalArrangement=Arrangement.spacedBy(12.dp)) {
                items(DramaCategories.list.size) { idx ->
                    val cat = DramaCategories.list[idx]
                    Card(Modifier.height(90.dp).clickable{}) {
                        Box(Modifier.fillMaxSize().padding(12.dp)) { Text(cat, style=MaterialTheme.typography.titleMedium) }
                    }
                }
            }
        }
    }
}

@Composable fun DramaPlayerScreen(id: String, nav: NavController) {
    Column(Modifier.fillMaxSize().padding(16.dp)) {
        Text("Player Drama ID: $id - Vertical Fullscreen")
        Button(onClick={}) { Text("Selesai Episode -> Iklan") }
        Button(onClick={ nav.navigate("vip_purchase") }) { Text("Beli VIP") }
    }
}

@Composable fun VipPurchaseScreen(nav: NavController) {
    Column(Modifier.padding(24.dp)) {
        Text("VIP DLOVID - 1 Bulan Rp30.000", style=MaterialTheme.typography.headlineSmall)
        Button(onClick={}) { Text("Bayar dengan QRIS") }
    }
}
