import 'package:flutter/material.dart';

class BerandaScreen extends StatefulWidget{const BerandaScreen({super.key});@override State<BerandaScreen> createState()=>_BerandaScreenState();}
class _BerandaScreenState extends State<BerandaScreen>{
  final List videos=[
    {"user":"@rocha_live","isLive":true,"desc":"🔴 LIVE sekarang lagi ngobrol sama followers!","views":"1.2K"},
    {"user":"@member1","isLive":false,"desc":"Video lucu rekaman asli camera - no copyright","views":"5K"},
    {"user":"@member2","isLive":false,"desc":"Video original masak-masak hari ini","views":"3K"},
    {"user":"@supervisor_live","isLive":true,"desc":"🔴 LIVE jualan + sawer gift","views":"800"},
  ];

  @override Widget build(BuildContext context){
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videos.length,
      itemBuilder: (_,i){
        var v=videos[i];
        return Stack(children:[
          Container(color:Colors.black,child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
            Icon(v['isLive'] as bool?true==true?Icons.live_tv:Icons.play_circle,size:80,color:v['isLive']==true?Colors.red:Colors.white24),
            const SizedBox(height:20),
            Text("1. Menonton video live dan video upload pengguna\n2. Beranda seperti TikTok\n${v['isLive']==true?"3. Pengguna sedang live tampil disini - ${v['user']}":"Video upload pengguna ${v['user']}"}",textAlign:TextAlign.center,style:const TextStyle(color:Colors.white70,fontSize:13)),
            const SizedBox(height:20),
            Text("AdMob Banner di bawah - AdMob Interstitial tiap 3 swipe",style:const TextStyle(color:Colors.amber,fontSize:10)),
          ]))),
          // Kanan - like comment gift
          Positioned(right:10,bottom:100,child:Column(children:[
            const Icon(Icons.favorite,color:Colors.white,size:35),Text(v['views'].toString(),style:const TextStyle(color:Colors.white,fontSize:10)),
            const SizedBox(height:20),const Icon(Icons.comment,color:Colors.white,size:35),const Text("120",style:TextStyle(color:Colors.white,fontSize:10)),
            const SizedBox(height:20),const Icon(Icons.card_giftcard,color:Colors.amber,size:35),const Text("Gift",style:TextStyle(color:Colors.amber,fontSize:10)),
          ])),
          // Bawah - deskripsi
          Positioned(left:10,bottom:20,right:80,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text(v['user'].toString(),style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:15,backgroundColor:v['isLive']==true?Colors.red:null)),
            const SizedBox(height:5),Text(v['desc'].toString(),style:const TextStyle(color:Colors.white70)),
          ])),
        ]);
      },
    );
  }
}
