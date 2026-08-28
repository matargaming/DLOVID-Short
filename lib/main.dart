import 'package:flutter/material.dart';
import 'screens/login/login_gate.dart';

void main() {
  runApp(const DLOVIDApp());
}

class DLOVIDApp extends StatelessWidget {
  const DLOVIDApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const SplashToLogin(),
    );
  }
}

class SplashToLogin extends StatefulWidget {
  const SplashToLogin({super.key});
  @override State<SplashToLogin> createState() => _SplashToLoginState();
}

class _SplashToLoginState extends State<SplashToLogin> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginGate()));
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 200, height: 200,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
          child: const Center(child: Text("D", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 120, fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }
}
