import '../services/tmdb_service.dart';
import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          // 7. Logo kecil VIP pojok atas
          IconButton(icon: Icon(Icons.workspace_premium, color: Colors.amber), onPressed: ()=> showVipDialog()),
          // 8. Fitur pencarian video
          IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){}),
        ],
      ),
      body: ListView(
        children: [
          // 1. Film campuran scroll kiri kanan
          SizedBox(height: 180, child: FutureBuilder(
            future: TmdbService.getMovies(),
            builder: (c,s) {
              if (!s.hasData) return Center(child: CircularProgressIndicator(color: Colors.amber));
              final movies = s.data as List;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (c,i) => Container(
                  width: 120, margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w500${movies[i]['poster_path']}"), fit: BoxFit.cover)),
                ),
              );
            }
          )),
          // 2. Kotak presentase undang teman dapat bonus koin
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.amber[700], borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Undang Teman Dapat Bonus", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Dapat 1000 Koin per teman", style: TextStyle(fontSize: 12)),
                ]),
                ElevatedButton(onPressed: (){}, child: Text("Undang Teman"), style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.amber))
              ],
            ),
          ),
          // 3. Kotak kolase film campuran dengan judul
          GridView.builder(
            shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7),
            itemCount: 6,
            itemBuilder: (c,i) => Card(color: Colors.grey[900], child: Column(children: [
              Expanded(child: Image.network("https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", fit: BoxFit.cover)),
              Padding(padding: EdgeInsets.all(8), child: Text("Film Campuran ${i+1} - Drakor/Barat/India", style: TextStyle(color: Colors.white, fontSize: 12))),
            ])),
          )
        ],
      ),
    );
  }

  void showVipDialog() {
    showDialog(context: context, builder: (c)=> AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text("Beli VIP", style: TextStyle(color: Colors.amber)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(title: Text("1 Bulan - Rp 15.000", style: TextStyle(color: Colors.white)), onTap: (){}),
        ListTile(title: Text("1 Tahun - Rp 120.000", style: TextStyle(color: Colors.white)), onTap: (){}),
      ]),
    ));
  }
}
