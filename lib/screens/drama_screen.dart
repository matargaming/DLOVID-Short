import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DramaScreen extends StatefulWidget { final bool isTablet; const DramaScreen({super.key, required this.isTablet}); @override State<DramaScreen> createState() => _DramaScreenState(); }
class _DramaScreenState extends State<DramaScreen> {
  List movies = [];
  @override void initState(){ super.initState(); fetch(); }
  Future<void> fetch() async { String key = dotenv.env['TMDB_API_KEY']??''; var res = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/all/week?api_key=$key')); if(res.statusCode==200){ setState(()=> movies = jsonDecode(res.body)['results']); } }
  @override Widget build(BuildContext context) { return Scaffold(body: Column(children: [SafeArea(child: Row(children: [const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal:12, vertical:6), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)), child: const Text("VIP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))), IconButton(icon: const Icon(Icons.search), onPressed: (){})])), SizedBox(height: widget.isTablet?250:180, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: movies.length, itemBuilder: (_,i)=> Container(width:120, margin: const EdgeInsets.all(6), child: Column(children: [Expanded(child: Image.network("https://image.tmdb.org/t/p/w500${movies[i]['poster_path']}", fit: BoxFit.cover, errorBuilder: (_,__,___)=>const Icon(Icons.movie))), Text(movies[i]['title']??movies[i]['name']??'', maxLines:1)])))), Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.isTablet?4:2), itemCount: movies.length, itemBuilder: (_,i)=> Card(child: Column(children: [Expanded(child: Image.network("https://image.tmdb.org/t/p/w500${movies[i]['poster_path']}", fit: BoxFit.cover)), Text(movies[i]['title']??'', maxLines:2)]))))])); }
}
