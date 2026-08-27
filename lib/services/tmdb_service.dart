import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_secrets.dart';

class TmdbService {
  static const _apiKey = AppSecrets.tmdbApiKey;
  static const _baseUrl = AppSecrets.tmdbBaseUrl;

  // Method yang dipanggil home_screen.dart kamu
  static Future<List<dynamic>> getMovies() async {
    if (_apiKey.isEmpty) return [];
    final url = Uri.parse('$_baseUrl/trending/movie/day?api_key=$_apiKey&language=id-ID');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['results'] ?? [];
    } else {
      return [];
    }
  }

  // Alias biar kompatibel dengan kode lama
  static Future<List<dynamic>> getTrending() => getMovies();

  static String imageUrl(String path) {
    if (path.isEmpty) return '';
    return 'https://image.tmdb.org/t/p/w500$path';
  }
}
