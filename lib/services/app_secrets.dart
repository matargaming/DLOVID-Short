// lib/services/app_secrets.dart
// DLOVID-Short - Secure Secrets Loader
// Server Key Tidak Masuk APK - Aman!
// Diambil dari --dart-define di GitHub Actions

class AppSecrets {
  // 6 Secrets dari Github Settings > Secrets
  static const String tmdbApiKey = String.fromEnvironment('TMDB_API_KEY');
  static const String midtransClientKey = String.fromEnvironment('MIDTRANS_CLIENT_KEY');
  static const String midtransServerKey = String.fromEnvironment('MIDTRANS_SERVER_KEY');
  static const String admobAppId = String.fromEnvironment('ADMOB_APP_ID');
  static const String admobBannerId = String.fromEnvironment('ADMOB_BANNER_ID');
  static const String admobInterId = String.fromEnvironment('ADMOB_INTER_ID');

  // Alias untuk kompatibilitas kode lama kamu
  static const String tmdbKey = tmdbApiKey;
  static const String midtransClient = midtransClientKey;
  static const String midtransServer = midtransServerKey;

  // Cek apakah secrets sudah ter-load dari GitHub Actions
  static bool get isReady {
    return tmdbApiKey.isNotEmpty && admobAppId.isNotEmpty;
  }

  // Untuk debug di local - jangan tampilkan di release
  static void debugPrint() {
    // ignore: avoid_print
    print('--- DLOVID Secrets Status ---');
    // ignore: avoid_print
    print('TMDB: ${tmdbApiKey.isEmpty ? "KOSONG" : "OK (${tmdbApiKey.length} char)"}');
    // ignore: avoid_print
    print('MIDTRANS CLIENT: ${midtransClientKey.isEmpty ? "KOSONG" : "OK"}');
    // ignore: avoid_print
    print('ADMOB APP: ${admobAppId.isEmpty ? "KOSONG" : "OK"}');
    // ignore: avoid_print
    print('-----------------------------');
  }

  // Base URL TMDB
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBase = 'https://image.tmdb.org/t/p/w500';
}
