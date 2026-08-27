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
      title: 'DLOVID-Short',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080808),
        primaryColor: const Color(0xFFD4AF37),
        useMaterial3: true,
      ),
      home: const LoginGate(),
    );
  }
}
