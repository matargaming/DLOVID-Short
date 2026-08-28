import 'package:flutter/material.dart';
import '../../main.dart';

class LoginGate extends StatefulWidget {
  const LoginGate({super.key});
  @override
  State<LoginGate> createState() => _LoginGateState();
}

class _LoginGateState extends State<LoginGate> {
  // Controller
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  final _ref = TextEditingController();
  final _otp = TextEditingController();
  final _p2 = TextEditingController();
  final _p3 = TextEditingController();

  bool _ob1 = true, _ob2 = true, _isAdminStage2 = false, _isDaftar = false;

  // === KONFIG ADMIN - POINT 10,11,12 ===
  static const String adminEmail = "matargaming17@gmail.com";
  static const String adminPass1 = "Bosmatar123.321";
  static const String adminPass2 = "Bosmatar456.654";
  static const String adminPass3 = "Bosmatar21100169830188";
  static const String referralOwner = "DLOVID-OWNER-001"; // kode referral pertama pemilik apk - POINT 8

  InputDecoration _dec(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      suffixIcon: suffix,
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red[700]),
    );
  }

  void _prosesLogin() {
    final email = _email.text.trim();
    final sandi = _pass.text.trim();

    // POINT 7 - Validasi kosong
    if (email.isEmpty || sandi.isEmpty) {
      _showError("Email/No HP dan Sandi wajib diisi - ditolak");
      return;
    }

    // POINT 10,11 - Cek admin tahap 1
    if (email == adminEmail && sandi == adminPass1) {
      setState(() => _isAdminStage2 = true);
      return;
    }

    // POINT 13 - Rangka ini pengguna belum bisa login, hanya admin
    _showError("AKSES DITOLAK: Pengguna belum bisa login. Hanya admin yang bisa login di rangka ini.");
  }

  void _prosesDaftar() {
    final email = _email.text.trim();
    final sandi = _pass.text.trim();
    final confirm = _confirm.text.trim();
    final ref = _ref.text.trim();
    final otp = _otp.text.trim();

    // POINT 9 - Daftar tanpa referral ditolak
    if (ref.isEmpty) {
      _showError("DITOLAK: Daftar tanpa kode referral tidak bisa!");
      return;
    }
    // POINT 8 - Validasi kode referral harus dari pemilik atau pengguna pertama
    if (ref!= referralOwner &&!ref.startsWith("DLOVID-")) {
      _showError("Kode referral tidak valid. Minta kode dari pemilik apk / pengguna pertama");
      return;
    }
    if (email.isEmpty || sandi.isEmpty || confirm.isEmpty || otp.isEmpty) {
      _showError("Semua field wajib diisi");
      return;
    }
    if (sandi!= confirm) {
      _showError("Confirm sandi tidak sama");
      return;
    }

    // Simulasi daftar sukses - generate kode referral baru untuk pengguna ini
    final newCode = "DLOVID-${email.substring(0, 3).toUpperCase()}-${DateTime.now().millisecondsSinceEpoch % 10000}";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Daftar sukses! Kode referral kamu: $newCode (simpan untuk bagikan ke pengguna berikutnya)"), backgroundColor: Colors.green[700], duration: const Duration(seconds: 4)),
    );
    setState(() => _isDaftar = false);
  }

  void _prosesAdminStage2() {
    if (_p2.text.trim()!= adminPass2) {
      _showError("Sandi 2 salah");
      return;
    }
    if (_p3.text.trim()!= adminPass3) {
      _showError("Sandi 3 salah");
      return;
    }
    // POINT 12 - Login ke panel admin
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNav()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // POINT 1 - Logo D gold diatas
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(color: Colors.amber[700], shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.6), blurRadius: 20)]),
              child: const Center(child: Text("D", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black))),
            ),
            const SizedBox(height: 12),
            Text("Referral Owner: $referralOwner", style: const TextStyle(color: Colors.white38, fontSize: 10)),
            const SizedBox(height: 24),

            if (!_isAdminStage2)...[
              // POINT 2 - Email/No HP
              TextField(controller: _email, style: const TextStyle(color: Colors.white), decoration: _dec("Email / No HP")),
              const SizedBox(height: 12),
              // POINT 3 - Sandi + intip
              TextField(
                controller: _pass, obscureText: _ob1, style: const TextStyle(color: Colors.white),
                decoration: _dec("Sandi", suffix: IconButton(icon: Icon(_ob1? Icons.visibility_off : Icons.visibility, color: Colors.amber), onPressed: () => setState(()=> _ob1 =!_ob1))),
              ),
              const SizedBox(height: 12),
              if (_isDaftar)...[
                // POINT 4 - Confirm + intip
                TextField(
                  controller: _confirm, obscureText: _ob2, style: const TextStyle(color: Colors.white),
                  decoration: _dec("Confirm Sandi", suffix: IconButton(icon: Icon(_ob2? Icons.visibility_off : Icons.visibility, color: Colors.amber), onPressed: () => setState(()=> _ob2 =!_ob2))),
                ),
                const SizedBox(height: 12),
                // POINT 6 - Daftar isi kode referral
                TextField(controller: _ref, style: const TextStyle(color: Colors.white), decoration: _dec("Kode Referral (Wajib) - Contoh: $referralOwner")),
                const SizedBox(height: 12),
                // POINT 5 - OTP via HP/Email
                TextField(controller: _otp, style: const TextStyle(color: Colors.white), decoration: _dec("OTP via HP/Email")),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700]),
                  onPressed: () => _isDaftar? _prosesDaftar() : _prosesLogin(),
                  child: Text(_isDaftar? "DAFTAR (Wajib Referral)" : "LOGIN", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
              TextButton(onPressed: () => setState(()=> _isDaftar =!_isDaftar), child: Text(_isDaftar? "Sudah punya akun? Login" : "Pengguna baru? Daftar isi kode referral", style: const TextStyle(color: Colors.amber))),
              if (!_isDaftar) const Padding(padding: EdgeInsets.only(top: 12), child: Text("Rangka: Hanya admin bisa login\nEmail: matargaming17@gmail.com\nPass1: Bosmatar123.321", textAlign: TextAlign.center, style: TextStyle(color: Colors.white24, fontSize: 11))),
            ] else...[
              // POINT 12 - Menu login admin 2 sandi
              const Text("LOGIN ADMIN TAHAP 2", style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Masukkan Sandi 2 & 3 terakhir", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              TextField(controller: _p2, obscureText: true, style: const TextStyle(color: Colors.white), decoration: _dec("Sandi 2 : Bosmatar456.654")),
              const SizedBox(height: 12),
              TextField(controller: _p3, obscureText: true, style: const TextStyle(color: Colors.white), decoration: _dec("Sandi 3 : Bosmatar21100169830188")),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700]), onPressed: _prosesAdminStage2, child: const Text("LOGIN PANEL ADMIN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
              TextButton(onPressed: () => setState(()=> _isAdminStage2 = false), child: const Text("Kembali", style: TextStyle(color: Colors.white54))),
            ]
          ],
        ),
      ),
    );
  }
}
