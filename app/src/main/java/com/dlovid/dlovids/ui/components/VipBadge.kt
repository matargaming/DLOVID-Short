package com.dlovid.dlovids.ui.components
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable

@Composable
fun VipBadge(isVip: Boolean) {
    if(isVip) Text("VIP AKTIF 👑") else Text("BELI VIP 1 BULAN 30.000")
}
