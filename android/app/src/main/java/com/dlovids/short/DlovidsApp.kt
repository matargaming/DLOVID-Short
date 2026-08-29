package com.dlovids.short

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.dlovids.short.admin.AdminDramaDashboard
import com.dlovids.short.ads.AdMobManager
import com.dlovids.short.core.FirebaseManager
import com.dlovids.short.core.Secrets
import com.dlovids.short.drama.DramaScreen
import com.dlovids.short.home.BerandaScreen
import com.dlovids.short.live.AgoraManager
import com.dlovids.short.plus.PlusMenu
import com.dlovids.short.vip.VipPurchaseScreen
import com.google.firebase.auth.FirebaseAuth
import androidx.compose.ui.platform.LocalContext

@Composable
fun DlovidsApp() {
    val context = LocalContext.current
    val navController = rememberNavController()
    val currentUser = FirebaseAuth.getInstance().currentUser
    val email = currentUser?.email ?: ""

    var showPlus by remember { mutableStateOf(false) }

    // REAL: Init semua SDK dari secrets
    LaunchedEffect(Unit) {
        FirebaseManager.init(context)
        AdMobManager.init(context) // pakai ADMOB_APP_ID secret
        AgoraManager.init(context) // pakai AGORA_APP_ID secret
    }

    Scaffold { pad ->
        Box(Modifier.padding(pad)) {
            NavHost(navController = navController, startDestination = "beranda") {

                composable("beranda") {
                    BerandaScreen(onOpenDrama = { id ->
                        navController.navigate("drama")
                    })
                }

                composable("drama") {
                    DramaScreen()
                }

                composable("admin") {
                    // REAL: Hanya ADMIN_EMAIL bisa akses
                    AdminDramaDashboard(currentEmail = email)
                }

                composable("vip") {
                    VipPurchaseScreen(onVipSuccess = {
                        navController.navigate("beranda")
                    })
                }
            }

            if (showPlus) {
                PlusMenu(onClose = { showPlus = false })
            }
        }
    }
}
