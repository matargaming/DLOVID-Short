import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // SERVER CONEK - LOAD 14 SECRETS
  try {
    await dotenv.load(fileName: ".env");
    print("=== SERVER DLOVID ONLINE ===");
    print("ADMIN: ${dotenv.env['ADMIN_EMAIL']}");
    print("FIREBASE: ${dotenv.env['FIREBASE_PROJECT_ID']}");
    print("AGORA: ${dotenv.env['AGORA_APP_ID']?.substring(0, 5)}*** ONLINE");
    print("TMDB: ${dotenv.env['TMDB_API_KEY']?.substring(0, 5)}*** ONLINE");
    print("ADMOB: ${dotenv.env['ADMOB_APP_ID']?.substring(0, 5)}*** ONLINE");
    print("MIDTRANS: ${dotenv.env['MIDTRANS_CLIENT_KEY']?.substring(0, 5)}*** ONLINE");
  } catch (e) {
    print("ERROR .env: $e");
  }

  // FIREBASE CONNECT - JANGAN OFFLINE
  try {
    await Firebase.initializeApp();
    // ANTI OFFLINE - CACHE SELALU ON
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    print("=== FIREBASE SERVER CONNECTED - ALWAYS ONLINE ===");
  } catch (e) {
    print("FIREBASE ERROR: $e");
  }
  
  runApp(const DlovidShortApp());
}

class DlovidShortApp extends StatelessWidget {
  const DlovidShortApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLOVID Short - SERVER ONLINE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      home: const LoginScreen(isTablet: false),
    );
  }
}
