import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<dynamic> login(String emailOrHp, String sandi) async {
    // logic login kamu
  }
  
  Future<void> register({required String emailOrHp, required String sandi, required String confirm, required String referralCode, required String otp}) async {
    // logic register kamu
  }

  Future<bool> adminStage2(String pass2, String pass3) async {
    // logic cek pass2 & pass3
    return true;
  }
}
