import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login/login_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DLOVIDApp());
}

class DLOVIDApp extends StatelessWidget {
  const DLOVIDApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget { const Splash({super.key}); @override State<Splash> createState()=>_SplashState();}
class _SplashState extends State<Splash>{
  @override void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>const LoginGate()));
    });
  }
  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[
          Image.asset('assets/images/logo_login.png', width: 200, height: 200,
            errorBuilder: (_,__,___)=> Container(width:150,height:150,decoration:BoxDecoration(color:Colors.black,borderRadius:BorderRadius.circular(30)),child:const Center(child:Text("DLOVID\nSHORT",textAlign:TextAlign.center,style:TextStyle(color:Color(0xFFD4AF37),fontSize:32,fontWeight:FontWeight.bold))))),
          const SizedBox(height:20),
          const CircularProgressIndicator(color: Colors.black),
          const SizedBox(height:10),
          const Text("Loading TMDB + AdMob + Midtrans...",style:TextStyle(color:Colors.black54,fontSize:11)),
        ]),
      ),
    );
  }
}
