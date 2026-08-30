package com.dlovid.dlovids.ui.theme
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

private val DarkColors = darkColorScheme(
    primary = Color(0xFF00E5FF),
    secondary = Color(0xFFFF00AA),
    background = Color(0xFF0A0A0A),
    surface = Color(0xFF121212)
)

@Composable
fun DLOVIDShortTheme(content: @Composable () -> Unit) {
    MaterialTheme(colorScheme = DarkColors, content = content)
}
