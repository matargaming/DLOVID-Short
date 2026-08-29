import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // SERVER 14 SECRETS - JANGAN OFFLINE
  await dotenv.load(fileName: ".env");
  
  await Firebase.initializeApp();
  
  runApp(const DlovidShortApp());
}

class DlovidShortApp extends StatelessWidget {
  const DlovidShortApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLOVID Short',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginScreen(isTablet: false),
    );
  }
}
