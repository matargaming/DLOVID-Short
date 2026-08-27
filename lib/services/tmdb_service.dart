import 'dart:convert';
import 'package:http/http.dart' as http;

class TmdbService {
  // Diambil dari --dart-define di GitHub Actions, bukan dari kode
  static const _apiKey = String.fromEnvironment('TMDB_API_KEY');
  static const _baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<dynamic>> getTrending() async {
    if (_apiKey.isEmpty) throw Exception('TMDB_API_KEY tidak ada di --dart-define');
    final res = await http.get(Uri.parse('$_baseUrl/trending/movie/day?api_key=$_apiKey'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['results'];
    } else {
      throw Exception('Gagal load trending: ${res.statusCode}');
    }
  }
  
  // Tambahkan method lain kamu di sini...
}
