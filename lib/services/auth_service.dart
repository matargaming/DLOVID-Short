import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<dynamic> login(String emailOrHp, String sandi) async {
    // TODO: ganti dengan logic kamu
    // return null jika mau masuk admin stage 2
    try {
      await _auth.signInWithEmailAndPassword(email: emailOrHp, password: sandi);
      return true;
    } catch (e) {
      return null; // biar masuk stage 2 sesuai kode kamu
    }
  }

  Future<void> register({required String emailOrHp, required String sandi, required String confirm, required String referralCode, required String otp}) async {
    if (sandi!= confirm) throw Exception('Confirm sandi tidak sama');
    if (referralCode.isEmpty) throw Exception('Kode referral wajib');
    await _auth.createUserWithEmailAndPassword(email: emailOrHp, password: sandi);
  }

  Future<bool> adminStage2(String pass2, String pass3) async {
    // Cek sandi admin kamu di sini, jangan di UI
    if (pass2 == 'Bosmatar456.654' && pass3 == 'Bosmatar21100169830188') {
      return true;
    }
    throw Exception('Sandi Admin 2/3 salah');
  }
}
