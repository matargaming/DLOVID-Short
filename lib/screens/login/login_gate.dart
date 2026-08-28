import 'dart:math';
import 'package:flutter/material.dart';
import '../../main.dart';

class LoginGate extends StatefulWidget {
  const LoginGate({super.key});
  @override
  State<LoginGate> createState() => _LoginGateState();
}

class _LoginGateState extends State<LoginGate> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  final _ref = TextEditingController();
  final _otp = TextEditingController();
  final _p2 = TextEditingController();
  final _p3 = TextEditingController();
  bool _ob1 = true, _ob2 = true, _isAdminStage2 = false, _isDaftar = false;
  String _generatedOtp = "";

  static const String adminEmail = "matargaming17@gmail.com";
  static const String adminPass1 = "Bosmatar123.321";
  static const String adminPass2 = "Bosmatar456.654";
  static const String adminPass3 = "Bosmatar21100169830188";
  static const String referralAdminKey = "DVS0000";
  static const String referralOwner = "DLOVID-OWNER-001";

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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red.shade700));
  }

  void _kirimOtp() {
    if (_email.text.trim().isEmpty) {
      _showError("Isi Email/No HP dulu");
      return;
    }
    final rand = Random();
    _generatedOtp = (100000 + rand.nextInt(900000)).toString();
    debugPrint("OTP $_generatedOtp konek Gmail admin $adminEmail");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP terkirim konek Gmail admin: $_generatedOtp"), backgroundColor: Colors.green.shade700, duration: const Duration(seconds: 5)),
    );
    setState(() {
      _otp.text = _generatedOtp;
    });
  }

  void _prosesLogin() {
    _showError("Rangka: Login user belum dibuka. Daftar dulu");
  }

  void _prosesDaftar() {
    final email = _email.text.trim();
    final sandi = _pass.text.trim();
    final confirm = _confirm.text.trim();
    final ref = _ref.text.trim();
    final otp = _otp.text.trim();

    if (ref.isEmpty) { _showError("Tanpa referral ditolak"); return; }
    if (email.isEmpty || sandi.isEmpty || confirm.isEmpty || otp.isEmpty) { _showError("Semua wajib isi"); return; }
    if (sandi != confirm) { _showError("Confirm tidak sama"); return; }
    if (_generatedOtp.isEmpty) { _showError("Klik Kirim OTP dulu"); return; }
    if (otp != _generatedOtp) { _showError("OTP salah"); return; }

    if (email == adminEmail && ref == referralAdminKey) {
      if (sandi != adminPass1) { _showError("Sandi 1 salah"); return; }
      setState(() { _isAdminStage2 = true; });
      return;
    }

    if (ref != referralOwner && ref != referralAdminKey && !ref.startsWith("DLOVID-")) {
      _showError("Referral tidak valid");
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Daftar sukses"), backgroundColor: Colors.green));
    setState(() { _isDaftar = false; });
  }

  void _prosesAdminStage2() {
    if (_p2.text.trim() != adminPass2) { _showError("Sandi 2 salah"); return; }
    if (_p3.text.trim() != adminPass3) { _showError("Sandi 3 salah"); return; }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainNav()));
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(controller: _email, style: const TextStyle(color: Colors.white), decoration: _dec("Email / No HP")),
        const SizedBox(height: 12),
        TextField(
          controller: _pass,
          obscureText: _ob1,
          style: const TextStyle(color: Colors.white),
          decoration: _dec("Sandi", suffix: IconButton(icon: Icon(_ob1 ? Icons.visibility_off : Icons.visibility, color: Colors.amber), onPressed: () { setState(() { _ob1 = !_ob1; }); })),
        ),
        const SizedBox(height: 12),
        if (_isDaftar)
          Column(
            children: [
              TextField(
                controller: _confirm,
                obscureText: _ob2,
                style: const TextStyle(color: Colors.white),
                decoration: _dec("Confirm Sandi", suffix: IconButton(icon: Icon(_ob2 ? Icons.visibility_off : Icons.visibility, color: Colors.amber), onPressed: () { setState(() { _ob2 = !_ob2; }); })),
              ),
              const SizedBox(height: 12),
              TextField(controller: _ref, style: const TextStyle(color: Colors.white), decoration: _dec("Kode Referral Wajib")),
              const SizedBox(height: 12),
              TextField(controller: _otp, style: const TextStyle(color: Colors.white), decoration: _dec("OTP via HP/Email")),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700), onPressed: _kirimOtp, child: const Text("Kirim OTP", style: TextStyle(color: Colors.black))),
              ),
              const SizedBox(height: 4),
              const Text("OTP konek ke Gmail admin", style: TextStyle(color: Colors.white24, fontSize: 10)),
              const SizedBox(height: 12),
            ],
          ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            onPressed: () { if (_isDaftar) { _prosesDaftar(); } else { _prosesLogin(); } },
            child: Text(_isDaftar ? "DAFTAR" : "LOGIN", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ),
        TextButton(onPressed: () { setState(() { _isDaftar = !_isDaftar; }); }, child: Text(_isDaftar ? "Sudah punya akun? Login" : "Pengguna baru? Daftar isi kode referral", style: const TextStyle(color: Colors.amber))),
      ],
    );
  }

  Widget _buildAdminStage2() {
    return Column(
      children: [
        const Text("LOGIN ADMIN TAHAP 2", style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        TextField(controller: _p2, obscureText: true, style: const TextStyle(color: Colors.white), decoration: _dec("Sandi 2")),
        const SizedBox(height: 12),
        TextField(controller: _p3, obscureText: true, style: const TextStyle(color: Colors.white), decoration: _dec("Sandi 3")),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), onPressed: _prosesAdminStage2, child: const Text("MASUK PANEL ADMIN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
        TextButton(onPressed: () { setState(() { _isAdminStage2 = false; }); }, child: const Text("Kembali", style: TextStyle(color: Colors.white54))),
      ],
    );
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
            Image.asset("assets/images/logo_login.png", width: 110, height: 110),
            const SizedBox(height: 30),
            _isAdminStage2 ? _buildAdminStage2() : _buildLoginForm(),
          ],
        ),
      ),
    );
  }
}
