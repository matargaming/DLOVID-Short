import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';

class SaranScreen extends StatefulWidget {
  @override
  _SaranScreenState createState() => _SaranScreenState();
}

class _SaranScreenState extends State<SaranScreen> {
  final PageController _pageController = PageController();
  List<dynamic> trending = [];
  bool isVip = false; // ambil dari Firestore nanti

  @override
  void initState() {
    super.initState();
    loadTrending();
  }

  loadTrending() async {
    trending = await TmdbService.getTrending(); // Film lagi ngetren
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder( // 1. Vertikal kayak TikTok, 2. Scroll keatas ganti film baru
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (i) {
        if (i == trending.length -1) loadTrending(); // Auto load baru
      },
      itemCount: trending.length,
      itemBuilder: (c,i) {
        final film = trending[i];
        return Stack(
          children: [
            // Video Player Vertikal Full
            Container(
              color: Colors.black,
              child: Center(child: Image.network("https://image.tmdb.org/t/p/w500${film['poster_path']}", fit: BoxFit.cover, width: double.infinity)),
            ),
            // 3. Icon kecil kotak episode kanan bawah - VIP bisa ganti
            Positioned(
              bottom: 100, right: 16,
              child: GestureDetector(
                onTap: (){
                  if (!isVip) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Non VIP tidak bisa ganti episode - harus urutan!")));
                    return;
                  }
                  showEpisodeDialog();
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.video_library, color: Colors.amber),
                ),
              ),
            ),
            Positioned(bottom: 20, left: 16, child: Text(film['title']??'Film Tren', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ],
        );
      },
    );
  }

  void showEpisodeDialog() {
    showModalBottomSheet(context: context, builder: (c)=> Container(
      height: 300, color: Colors.grey[900],
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemCount: 20,
        itemBuilder: (c,i)=> Card(color: Colors.amber, child: Center(child: Text("Eps ${i+1}"))),
      ),
    ));
  }
}
