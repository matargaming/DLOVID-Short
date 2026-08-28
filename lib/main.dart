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
      if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginGate()));
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/icon/icon.png', width: 250)),
    );
  }
}
