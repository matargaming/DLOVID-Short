import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<dynamic> login(String emailOrHp, String sandi) async {
    try {
      await _auth.signInWithEmailAndPassword(email: emailOrHp, password: sandi);
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<void> register({required String emailOrHp, required String sandi, required String confirm, required String referralCode, required String otp}) async {
    if (sandi != confirm) throw Exception('Confirm sandi tidak sama');
    if (referralCode.isEmpty) throw Exception('Kode referral wajib');
    await _auth.createUserWithEmailAndPassword(email: emailOrHp, password: sandi);
  }

  Future<bool> adminStage2(String pass2, String pass3) async {
    if (pass2 == 'Bosmatar456.654' && pass3 == 'Bosmatar21100169830188') {
      return true;
    }
    throw Exception('Sandi Admin 2/3 salah');
  }
}
