package com.dlov.gold.ui.components
import androidx.compose.runtime.Composable
@Composable
fun VipBadge(isVip: Boolean) {
    if(isVip) Text("VIP 👑") else Text("Beli VIP")
}
