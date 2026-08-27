import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // --- ADMIN CREDENTIALS (SESUI REQUEST BOS) ---
  static const String adminEmail = "matargaming17@gmail.com";
  static const String adminPass1 = "Bosmatar123.321";
  static const String adminPass2 = "Bosmatar456.654";
  static const String adminPass3 = "Bosmatar21100169830188";

  // Kode Referral Pertama Milik Pemilik APK
  static const String rootReferralCode = "BOSMATAR-ROOT-001";

  // Cek Referral Wajib - Point 9 Bos
  Future<bool> validateReferral(String code) async {
    if (code == rootReferralCode) return true;
    final q = await _db.collection('users').where('myReferralCode', isEqualTo: code).limit(1).get();
    return q.docs.isNotEmpty;
  }

  // Login - Point 7 & 13
  Future<User?> login(String emailOrHp, String sandi) async {
    // Cek apakah admin
    if (emailOrHp.toLowerCase() == adminEmail) {
      if (sandi!= adminPass1) throw Exception("Sandi 1 Salah - Ditolak APK!");
      return null; // Lanjut ke tahap admin 2
    }
    // Untuk pengguna biasa - BLOKIR DULU (Point 13)
    throw Exception("Pengguna biasa belum bisa login - Hanya Admin!");
  }

  Future<bool> adminStage2(String pass2, String pass3) async {
    if (pass2!= adminPass2) throw Exception("Sandi 2 Salah!");
    if (pass3!= adminPass3) throw Exception("Sandi 3 Salah!");
    // Login Firebase asli untuk admin
    final cred = await _auth.signInWithEmailAndPassword(email: adminEmail, password: adminPass1);
    return cred.user!= null;
  }

  // Daftar Baru Wajib Referral - Point 6,8,9
  Future<void> register({required String emailOrHp, required String sandi, required String confirm, required String referralCode, required String otp}) async {
    if (sandi!= confirm) throw Exception("Confirm Sandi Tidak Sama!");
    if (referralCode.isEmpty) throw Exception("Daftar tanpa referral ditolak APK!");
    final valid = await validateReferral(referralCode);
    if (!valid) throw Exception("Kode Referral Tidak Valid - Ditolak!");
    // TODO: Verifikasi OTP via HP/Email disini
    if (otp.length < 4) throw Exception("OTP Salah!");
  }
}
