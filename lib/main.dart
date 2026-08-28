import 'package:flutter/material.dart';
import 'screens/saran_screen.dart';
import 'screens/bonus_screen.dart';
import 'screens/akun_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DlovidApp());
}

class DlovidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNav(), // BYPASS LOGIN DULU
    );
  }
}
// ... MainNav tetep sama
