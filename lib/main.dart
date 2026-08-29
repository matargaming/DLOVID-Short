import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const ADMIN_EMAIL = String.fromEnvironment('ADMIN_EMAIL', defaultValue: 'admin@dlovid.com');
const ADMIN_KEY_1 = String.fromEnvironment('ADMIN_KEY_1', defaultValue: 'DLOVID1');
const ADMIN_KEY_2 = String.fromEnvironment('ADMIN_KEY_2', defaultValue: 'DLOVID2');
const ADMIN_KEY_3 = String.fromEnvironment('ADMIN_KEY_3', defaultValue: 'DLOVID3');
const TMDB_KEY = String.fromEnvironment('TMDB_API_KEY', defaultValue: '');

void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false, home:LoginScreen(), theme:ThemeData.dark().copyWith(scaffoldBackgroundColor:Color(0xFF0A0A0A), primaryColor:Color(0xFFD4AF37))));

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState()=>_LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  bool o1=true,o2=true;
  final e=TextEditingController(),p=TextEditingController(),c=TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(body:Padding(padding:EdgeInsets.all(24), child:Column(mainAxisAlignment:MainAxisAlignment.center, children:[
      Image.asset('assets/logo_dlovid.png', height:100, errorBuilder:(_,__,___)=>Icon(Icons.movie,size:80,color:Color(0xFFD4AF37))),
      SizedBox(height:12),
      Text('DLOVID SHORT', style:TextStyle(fontSize:24,fontWeight:FontWeight.bold,color:Color(0xFFD4AF37))),
      SizedBox(height:20),
      TextField(controller:e, decoration:InputDecoration(labelText:'Email / No HP', border:OutlineInputBorder())),
      SizedBox(height:10),
      TextField(controller:p, obscureText:o1, decoration:InputDecoration(labelText:'Sandi', border:OutlineInputBorder(), suffixIcon:IconButton(icon:Icon(o1?Icons.visibility_off:Icons.visibility), onPressed:()=>setState(()=>o1=!o1)))),
      SizedBox(height:10),
      TextField(controller:c, obscureText:o2, decoration:InputDecoration(labelText:'Confirm Sandi', border:OutlineInputBorder(), suffixIcon:IconButton(icon:Icon(o2?Icons.visibility_off:Icons.visibility), onPressed:()=>setState(()=>o2=!o2)))),
      SizedBox(height:20),
      SizedBox(width:double.infinity,height:50, child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFD4AF37)), onPressed:(){
        if(e.text==ADMIN_EMAIL && p.text==ADMIN_KEY_1) Navigator.push(context, MaterialPageRoute(builder:(_)=>Admin2()));
        else if(p.text!=c.text || e.text.isEmpty) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Ditolak')));
        else Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>MainNav()));
      }, child:Text('LOGIN', style:TextStyle(color:Colors.black)))),
    ])));
  }
}
class Admin2 extends StatelessWidget{
  final k2=TextEditingController(),k3=TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar:AppBar(title:Text('ADMIN KEY 2 & 3')), body:Padding(padding:EdgeInsets.all(24), child:Column(children:[
      TextField(controller:k2, decoration:InputDecoration(labelText:'ADMIN_KEY_2')),
      TextField(controller:k3, decoration:InputDecoration(labelText:'ADMIN_KEY_3')),
      SizedBox(height:20),
      ElevatedButton(onPressed:(){
        if(k2.text==ADMIN_KEY_2 && k3.text==ADMIN_KEY_3) Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>MainNav(isAdmin:true)));
      }, child:Text('MASUK ADMIN'))
    ])));
  }
}
class MainNav extends StatefulWidget{
  final bool isAdmin; MainNav({this.isAdmin=false});
  @override
  State<MainNav> createState()=>_MainNavState();
}
class _MainNavState extends State<MainNav>{
  int idx=0;
  @override
  Widget build(BuildContext context){
    List pages=[DramaScreen(), Beranda(), Plus(), Pesan(), Akun()];
    return Scaffold(body:pages[idx], bottomNavigationBar:BottomNavigationBar(currentIndex:idx, onTap:(i)=>setState(()=>idx=i), selectedItemColor:Color(0xFFD4AF37), type:BottomNavigationBarType.fixed, backgroundColor:Colors.black, items:[
      BottomNavigationBarItem(icon:Icon(Icons.movie), label:'Drama'),
      BottomNavigationBarItem(icon:Image.asset('assets/home.png', height:24, errorBuilder:(_,__,___)=>Icon(Icons.home)), label:'Beranda'),
      BottomNavigationBarItem(icon:Icon(Icons.add_box), label:'Plus'),
      BottomNavigationBarItem(icon:Icon(Icons.message), label:'Pesan'),
      BottomNavigationBarItem(icon:Icon(Icons.person), label:'Akun'),
    ]));
  }
}
class DramaScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    bool tablet=MediaQuery.of(context).size.width>600;
    return Scaffold(appBar:AppBar(title:Image.asset('assets/logo_dlovid.png', height:28, errorBuilder:(_,__,___)=>Text('DLOVID')), actions:[GestureDetector(onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>Vip())), child:Image.asset('assets/logo_vip.png', height:30, errorBuilder:(_,__,___)=>Icon(Icons.workspace_premium, color:Color(0xFFD4AF37)))), SizedBox(width:12)]), body:GridView.builder(padding:EdgeInsets.all(8), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:tablet?4:2, childAspectRatio:0.7), itemCount:20, itemBuilder:(_,i)=>Card(color:Color(0xFF1A1A1A), child:InkWell(onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>Video())), child:Column(children:[Expanded(child:Icon(Icons.play_circle_fill, size:50, color:Color(0xFFD4AF37))), Text('Drama ${i+1}'), Text('Drakor/Dracin/Barat/India', style:TextStyle(fontSize:9, color:Colors.white54))])))));
  }
}
class Video extends StatelessWidget{
  @override
  Widget build(BuildContext context){return Scaffold(backgroundColor:Colors.black, body:Center(child:Icon(Icons.play_circle, size:80, color:Color(0xFFD4AF37))));}
}
class Beranda extends StatelessWidget{
  @override
  Widget build(BuildContext context){return PageView.builder(scrollDirection:Axis.vertical, itemCount:10, itemBuilder:(_,i)=>Container(color:Colors.black, child:Center(child:Text('Beranda TikTok Style - Live ${i+1}'))));}
}
class Plus extends StatelessWidget{
  @override
  Widget build(BuildContext context){return Scaffold(body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center, children:[ElevatedButton(onPressed:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>Vip())), child:Text('LIVE - Butuh VIP')), SizedBox(height:10), ElevatedButton(onPressed:(){}, child:Text('UPLOAD'))])));}
}
class Pesan extends StatelessWidget{
  @override
  Widget build(BuildContext context){return Scaffold(appBar:AppBar(title:Text('Pesan')), body:ListView.builder(itemCount:10, itemBuilder:(_,i)=>ListTile(title:Text('User ${i+1}'))));}
}
class Akun extends StatelessWidget{
  @override
  Widget build(BuildContext context){return Scaffold(appBar:AppBar(title:Text('Akun')), body:ListView(padding:EdgeInsets.all(16), children:[CircleAvatar(radius:40, backgroundImage:AssetImage('assets/icon_apk.png')), ListTile(title:Text('Pendapatan Koin')), ListTile(title:Text('Dompet')), ListTile(title:Text('WD Potongan 20%'))]));}
}
class Vip extends StatelessWidget{
  @override
  Widget build(BuildContext context){return Scaffold(appBar:AppBar(title:Text('VIP')), body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center, children:[Image.asset('assets/logo_vip.png', height:80, errorBuilder:(_,__,___)=>Icon(Icons.workspace_premium, size:60, color:Color(0xFFD4AF37))), Text('VIP 1 Bulan Rp 30.000 - QRIS'), Container(height:100,width:100,color:Colors.white, child:Center(child:Text('QRIS', style:TextStyle(color:Colors.black))))])));}
}
