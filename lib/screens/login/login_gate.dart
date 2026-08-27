import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _referralCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  final _adminPass2Ctrl = TextEditingController();
  final _adminPass3Ctrl = TextEditingController();

  bool _obscure1 = true, _obscure2 = true;
  bool _isAdminStage2 = false;
  bool _isDaftar = false;
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 60),
            // 1. Logo D Gold Diatas
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                color: Colors.amber[700],
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.amber, blurRadius: 20)]
              ),
              child: Center(child: Text("D", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black))),
            ),
            SizedBox(height: 30),

            if (!_isAdminStage2)...[
              // 2. Email / No HP
              _field(_emailCtrl, "Email / No HP"),
              SizedBox(height: 12),
              // 3. Sandi + intip
              _field(_passCtrl, "Sandi", isPass: true, obscure: _obscure1, toggle: ()=> setState(()=> _obscure1 =!_obscure1)),
              SizedBox(height: 12),
              // 4. Confirm + intip (hanya pas daftar)
              if (_isDaftar)...[
                _field(_confirmCtrl, "Confirm Sandi", isPass: true, obscure: _obscure2, toggle: ()=> setState(()=> _obscure2 =!_obscure2)),
                SizedBox(height: 12),
                // 6. Kode Referral
                _field(_referralCtrl, "Kode Referral (Wajib)"),
                SizedBox(height: 12),
                // 5. OTP
                _field(_otpCtrl, "OTP via HP/Email"),
                SizedBox(height: 12),
              ],

              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700], minimumSize: Size(double.infinity, 50)),
                onPressed: () async {
                  try {
                    if (_isDaftar) {
                      await _auth.register(
                        emailOrHp: _emailCtrl.text,
                        sandi: _passCtrl.text,
                        confirm: _confirmCtrl.text,
                        referralCode: _referralCtrl.text,
                        otp: _otpCtrl.text
                      );
                    } else {
                      final res = await _auth.login(_emailCtrl.text, _passCtrl.text);
                      if (res == null) {
                        // Masuk tahap admin
                        setState(()=> _isAdminStage2 = true);
                        return;
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text(_isDaftar? "DAFTAR (Wajib Referral)" : "LOGIN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: ()=> setState(()=> _isDaftar =!_isDaftar),
                child: Text(_isDaftar? "Sudah punya akun? Login" : "Pengguna baru? Daftar isi kode referral", style: TextStyle(color: Colors.amber)),
              )
            ] else...[
              // 12. Menu Login Admin - Petunjuk 2 sandi terakhir
              Text("LOGIN ADMIN TAHAP 2", style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text("Masukkan Sandi 2 & 3", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 12),
              _field(_adminPass2Ctrl, "Sandi 2 : Bosmatar456.654", isPass: true),
              SizedBox(height: 12),
              _field(_adminPass3Ctrl, "Sandi 3 : Bosmatar21100169830188", isPass: true),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700], minimumSize: Size(double.infinity, 50)),
                onPressed: () async {
                  try {
                    final ok = await _auth.adminStage2(_adminPass2Ctrl.text, _adminPass3Ctrl.text);
                    if (ok) Navigator.pushReplacementNamed(context, '/admin');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text("MASUK PANEL ADMIN", style: TextStyle(color: Colors.black)),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String hint, {bool isPass=false, bool obscure=false, VoidCallback? toggle}) {
    return TextField(
      controller: c,
      obscureText: isPass? obscure : false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
        filled: true, fillColor: Colors.grey[900],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: isPass? IconButton(icon: Icon(obscure? Icons.visibility_off : Icons.visibility, color: Colors.amber), onPressed: toggle) : null,
      ),
    );
  }
}
