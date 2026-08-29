// COMPOSE - PAKAI BOM BIAR GAK BENTROK VERSI LAGI
val composeBom = platform("androidx.compose:compose-bom:2024.02.00")
implementation(composeBom)
implementation("androidx.compose.ui:ui")
implementation("androidx.compose.ui:ui-tooling-preview")
implementation("androidx.compose.material3:material3")
implementation("androidx.compose.ui:ui-tooling")
implementation("androidx.compose.material:material-icons-extended")

// coil & lainnya tetap
implementation("io.coil-kt:coil-compose:2.5.0")
