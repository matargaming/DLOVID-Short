import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DramaScreen extends StatefulWidget{const DramaScreen({super.key});@override State<DramaScreen> createState()=>_DramaScreenState();}
class _DramaScreenState extends State<DramaScreen>{
  List movies=[]; bool loading=true;
  final String tmdbKey="TMDB_API_KEY"; // nanti diambil dari --dart-define atau secret

  @override void initState(){super.initState(); fetchTrending();}

  Future fetchTrending() async {
    // 1. Film campuran Drakor,Dracin,Barat,India tampilan paling atas bisa scroll kiri kanan dari API TMDB
    try{
      var url=Uri.parse("https://api.themoviedb.org/3/trending/all/week?api_key=YOUR_TMDB_KEY");
      // Kalau pakai secret Bos, ganti YOUR_TMDB_KEY dengan yang dari GitHub Actions
      var res=await http.get(url);
      if(res.statusCode==200){
        var data=jsonDecode(res.body);
        setState((){movies=data['results']; loading=false;});
      }else{
        // fallback dummy biar gak kosong
        setState((){movies=List.generate(10,(i)=>{"title":"Drama ${i+1} - Drakor Dracin Barat India","poster_path":null}); loading=false;});
      }
    }catch(e){
      setState((){movies=List.generate(10,(i)=>{"title":"Drama ${i+1}","poster_path":null}); loading=false;});
    }
  }

  @override Widget build(BuildContext context){
    if(loading) return const Scaffold(backgroundColor:Colors.black,body:Center(child:CircularProgressIndicator(color:Colors.amber)));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor:Colors.black,title:const Text("MENU DRAMA",style:TextStyle(color:Colors.amber,fontSize:16,fontWeight:FontWeight.bold)),actions:[
        IconButton(onPressed:(){ showSearch(context:context,delegate:DramaSearch(movies)); },icon:const Icon(Icons.search,color:Colors.white)), // 6. fitur pencarian video
        GestureDetector(onTap:(){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("5. Pengguna klik VIP langsung diarahkan ke menu akun untuk pembelian 1 BLN 30.000"))); },child:Container(margin:const EdgeInsets.only(right:12),padding:const EdgeInsets.symmetric(horizontal:10,vertical:5),decoration:BoxDecoration(color:Colors.amber,borderRadius:BorderRadius.circular(8)),child:const Text("VIP 30K",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:11)))), // 4 & 5 VIP
      ]),
      body: Column(children:[
        // 1. Film campuran atas scroll kiri kanan
        SizedBox(height:180,child:ListView.builder(scrollDirection:Axis.horizontal,itemCount:movies.length,itemBuilder:(_,i){
          var m=movies[i];
          return GestureDetector(onTap:(){ Navigator.push(context,MaterialPageRoute(builder:(_)=> FullscreenDrama(title:m['title']??m['name']??"Drama ${i+1}"))); },
            child: Container(width:120,margin:const EdgeInsets.all(6),decoration:BoxDecoration(color:Colors.grey.shade900,borderRadius:BorderRadius.circular(12),image:m['poster_path']!=null?DecorationImage(image:NetworkImage("https://image.tmdb.org/t/p/w200${m['poster_path']}"),fit:BoxFit.cover):null),child:m['poster_path']==null?Center(child:Text(m['title'],textAlign:TextAlign.center,style:const TextStyle(color:Colors.white70,fontSize:10))):null));
        })),
        const Padding(padding:EdgeInsets.all(8),child:Align(alignment:Alignment.centerLeft,child:Text("2. Kolase film campuran judul langsung fullscreen vertikal\n3. Film terisi otomatis online setiap Minggu diganti update trend diatur AI",style:TextStyle(color:Colors.white54,fontSize:10)))),
        // 2. Kolase dibawah
        Expanded(child:GridView.builder(padding:const EdgeInsets.all(8),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:0.6),itemCount:movies.length,itemBuilder:(_,i){
          var m=movies[i];
          return GestureDetector(onTap:(){ Navigator.push(context,MaterialPageRoute(builder:(_)=> FullscreenDrama(title:m['title']??m['name']??"Drama ${i+1}"))); },
            child: Container(margin:const EdgeInsets.all(4),decoration:BoxDecoration(color:Colors.grey.shade900,borderRadius:BorderRadius.circular(10)),child:Column(children:[Expanded(child:Container(decoration:BoxDecoration(borderRadius:const BorderRadius.vertical(top:Radius.circular(10)),image:m['poster_path']!=null?DecorationImage(image:NetworkImage("https://image.tmdb.org/t/p/w200${m['poster_path']}"),fit:BoxFit.cover):null),child:m['poster_path']==null?const Icon(Icons.movie,color:Colors.white24):null)),Padding(padding:const EdgeInsets.all(4),child:Text(m['title']??m['name']??"Drama",maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Colors.white70,fontSize:9)))])));
        })),
      ]),
      floatingActionButton: FloatingActionButton.small(backgroundColor:Colors.amber,onPressed:(){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("7. Tombol ganti episode kanan bawah - 8. VIP bebas pilih episode"))); },child:const Icon(Icons.skip_next,color:Colors.black)),
    );
  }
}

class FullscreenDrama extends StatelessWidget{final String title;const FullscreenDrama({super.key,required this.title});@override Widget build(BuildContext context){return Scaffold(backgroundColor:Colors.black,body:Stack(children:[Center(child:Text("Fullscreen vertikal nonton\n$title\n\n(ADA IKLAN SELESAI EPISODE - AdMob Interstitial)",textAlign:TextAlign.center,style:const TextStyle(color:Colors.white))),Positioned(top:40,left:10,child:IconButton(icon:const Icon(Icons.arrow_back,color:Colors.white),onPressed:()=>Navigator.pop(context))) ]));}}
class DramaSearch extends SearchDelegate{final List movies;DramaSearch(this.movies);@override List<Widget> buildActions(BuildContext context)=>[IconButton(icon:const Icon(Icons.clear),onPressed:()=>query="")];@override Widget buildLeading(BuildContext context)=>IconButton(icon:const Icon(Icons.arrow_back),onPressed:()=>close(context,null));@override Widget buildResults(BuildContext context){var res=movies.where((m)=>(m['title']??m['name']??"").toString().toLowerCase().contains(query.toLowerCase())).toList();return ListView.builder(itemCount:res.length,itemBuilder:(_,i)=>ListTile(title:Text(res[i]['title']??res[i]['name']??"",style:const TextStyle(color:Colors.white)),onTap:()=> Navigator.push(context,MaterialPageRoute(builder:(_)=> FullscreenDrama(title:res[i]['title']??res[i]['name'])))));}@override Widget buildSuggestions(BuildContext context)=>Container(color:Colors.black,child:const Center(child:Text("Ketik judul Drakor/Dracin/Barat/India",style:TextStyle(color:Colors.white54))));}
