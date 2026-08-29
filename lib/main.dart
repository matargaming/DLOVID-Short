import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // --- SERVER CONEK 14 SECRETS - JANGAN OFFLINE ---
  try {
    await dotenv.load(fileName: ".env");
    print("✅ DLOVID SERVER ONLINE");
    print("ADMIN: ${dotenv.env['ADMIN_EMAIL']}");
    print("FIREBASE: ${dotenv.env['FIREBASE_PROJECT_ID']}");
    print("AGORA: ${dotenv.env['AGORA_APP_ID']}");
    print("TMDB: ${dotenv.env['TMDB_API_KEY']}");
    print("ADMOB: ${dotenv.env['ADMOB_APP_ID']}");
  } catch (e) {
    print("⚠️ .env belum kebaca: $e");
  }

  // --- FIREBASE ALWAYS ONLINE ---
  await Firebase.initializeApp();
  
  // INI KUNCI BIAR GAK OFFLINE BOS!
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  
  // Paksa Firestore online terus
  await FirebaseFirestore.instance.enableNetwork();
  
  print("🔥 FIREBASE CONNECTED - SERVER ONLINE 24 JAM");

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
      ),
      home: const LoginScreen(isTablet: false),
    );
  }
}
