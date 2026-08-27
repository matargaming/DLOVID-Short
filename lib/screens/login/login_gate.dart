import 'package:flutter/material.dart';
import '../../widgets/universal_layout.dart';
import '../admin/admin_panel.dart';

class LoginGate extends StatefulWidget {
  const LoginGate({super.key});
  @override
  State<LoginGate> createState() => _LoginGateState();
}

class _LoginGateState extends State<LoginGate> {
  // Controller sesuai poin Bos
  final _emailHP = TextEditingController(); // Poin 2: Email/No HP
  final _pass = TextEditingController(); // Poin 3: Sandi + intip
  final _confirm = TextEditingController(); // Poin 4: Confirm + intip
  final _otp = TextEditingController(); // Poin 5: OTP via HP/Email
  final _referral = TextEditingController(); // Poin 6: Kode referral

  bool _obs1 = true;
  bool _obs2 = true;
  int _step = 1; // 1=Login Gate, 2=Sandi2, 3=Sandi3

  // Poin 8, 10, 11, 12 - Kode asli pemilik APK
  final String adminEmail = "matargaming17@gmail.com";
  final String ownerReferral = "DLOVID-OWNER-001"; // Poin 8: Kode referral pertama pemilik APK
  final String s1 = "Bosmatar123.321"; // Poin 11
  final String s2 = "Bosmatar456.654"; // Poin 12
  final String s3 = "BOSMATAR21100169830188"; // Poin 12

  void _login() {
    // Poin 9: Daftar tanpa referral DITOLAK
    if (_referral.text.trim().isEmpty) {
      snack("Daftar tanpa Referral DITOLAK APK! Wajib isi kode referral");
      return;
    }
    // Poin 13: Rangka ini pengguna belum bisa login, hanya ADMIN
    if (_emailHP.text.trim() != adminEmail) {
      snack("RANGKA INI: Hanya ADMIN bisa login, user biasa BELUM AKTIF");
      return;
    }
    // Poin 5: OTP wajib
    if (_otp.text.trim().isEmpty) {
      snack("OTP via HP/Email wajib diisi!");
      return;
    }
    // Poin 7: Jika tidak sesuai email/hp, sandi ditolak
    if (_pass.text != s1) {
      snack("Email/No HP atau Sandi tidak sesuai - DITOLAK APK!");
      return;
    }
    // Poin 4: Confirm harus sama
    if (_confirm.text != _pass.text) {
      snack("Confirm Sandi tidak sama!");
      return;
    }
    // Lolos Sandi 1 -> Masuk menu login admin (Poin 11)
    setState(() => _step = 2);
    _pass.clear();
  }

  void _sandi2() {
    if (_pass.text == s2) {
      setState(() => _step = 3);
      _pass.clear();
    } else {
      snack("Sandi 2 Salah! Petunjuk: Masukkan sandi ke-2");
    }
  }

  void _sandi3() {
    if (_pass.text == s3) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminPanel()));
    } else {
      snack("Sandi 3 Salah! Petunjuk: Masukkan sandi final");
    }
  }

  void snack(String m) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(m), backgroundColor: Colors.red, duration: Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UniversalLayout(
        mobile: _form(),
        tablet: Row(children: [
          Expanded(
            child: Container(
              color: Color(0xFF111111),
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  DGoldLogo(size: 150),
                  SizedBox(height: 20),
                  Text("DLOVID-Short", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 32, fontWeight: FontWeight.bold)),
                  Text("UNIVERSAL ORIGINAL", style: TextStyle(color: Colors.white54)),
                ]),
              ),
            ),
          ),
          Expanded(child: _form()),
        ]),
      ),
    );
  }

  Widget _form() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(children: [
        SizedBox(height: 30),
        // Poin 1: Logo D gold diatas
        DGoldLogo(size: 100),
        SizedBox(height: 16),
        Text(
          _step == 1 ? "LOGIN GATE ORIGINAL" : _step == 2 ? "LOGIN ADMIN - SANDI 2" : "LOGIN ADMIN - SANDI 3 FINAL",
          style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        if (_step == 1)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text("Kode Referral Pemilik: $ownerReferral", style: TextStyle(color: Colors.white38, fontSize: 11)),
          ),
        SizedBox(height: 24),
        if (_step == 1) ...[
          field(_emailHP, "Email / No HP (Poin 2)", Icons.email),
          field(_otp, "OTP via HP/Email (Poin 5)", Icons.sms, isOTP: true),
          field(_pass, "Sandi + intip (Poin 3)", Icons.lock, isPass: true, obs: _obs1, toggle: () => setState(() => _obs1 = !_obs1)),
          field(_confirm, "Confirm + intip (Poin 4)", Icons.lock_outline, isPass: true, obs: _obs2, toggle: () => setState(() => _obs2 = !_obs2)),
          field(_referral, "Kode Referral WAJIB (Poin 6 & 9)", Icons.card_giftcard),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37), padding: EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: _login,
              child: Text("LOGIN / DAFTAR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          SizedBox(height: 12),
          Text("Poin 13: Rangka ini hanya ADMIN bisa login", style: TextStyle(color: Colors.white30, fontSize: 11), textAlign: TextAlign.center),
        ] else ...[
          field(_pass, _step == 2 ? "Masukkan Sandi 2 (Poin 12)" : "Masukkan Sandi 3 Final (Poin 12)", Icons.security, isPass: true, obs: true, toggle: () {}),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37), padding: EdgeInsets.all(16)),
              onPressed: _step == 2 ? _sandi2 : _sandi3,
              child: Text(_step == 2 ? "LANJUT SANDI 3" : "MASUK PANEL ADMIN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          if (_step == 2)
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text("Petunjuk: Hanya kasih masuk 2 sandi untuk terakhir", style: TextStyle(color: Colors.white38, fontSize: 12)),
            ),
        ]
      ]),
    );
  }

  Widget field(TextEditingController c, String l, IconData i, {bool isPass = false, bool obs = false, bool isOTP = false, VoidCallback? toggle}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        obscureText: isPass ? obs : false,
        keyboardType: isOTP ? TextInputType.number : TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: l,
          labelStyle: TextStyle(color: Colors.white54, fontSize: 13),
          prefixIcon: Icon(i, color: Color(0xFFD4AF37)),
          suffixIcon: isPass ? IconButton(icon: Icon(obs ? Icons.visibility_off : Icons.visibility, color: Colors.white54), onPressed: toggle) : null,
          filled: true,
          fillColor: Color(0xFF1E1E1E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white24)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white24)),
        ),
      ),
    );
  }
}
