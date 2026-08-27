import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginGate extends StatefulWidget {
  const LoginGate({super.key});
  @override
  State<LoginGate> createState() => _LoginGateState();
}

class _LoginGateState extends State<LoginGate> {
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
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    _referralCtrl.dispose();
    _otpCtrl.dispose();
    _adminPass2Ctrl.dispose();
    _adminPass3Ctrl.dispose();
    super.dispose();
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
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                color: Colors.amber[700],
                shape: BoxShape.circle,
                boxShadow: const [BoxShadow(color: Colors.amber, blurRadius: 20)]
              ),
              child: const Center(child: Text("D", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black))),
            ),
            const SizedBox(height: 30),
            if (!_isAdminStage2)...[
              _field(_emailCtrl, "Email / No HP"),
              const SizedBox(height: 12),
              _field(_passCtrl, "Sandi", isPass: true, obscure: _obscure1, toggle: () => setState(()=> _obscure1 =!_obscure1)),
              const SizedBox(height: 12),
              if (_isDaftar)...[
                _field(_confirmCtrl, "Confirm Sandi", isPass: true, obscure: _obscure2, toggle: () => setState(()=> _obscure2 =!_obscure2)),
                const SizedBox(height: 12),
                _field(_referralCtrl, "Kode Referral (Wajib)"),
                const SizedBox(height: 12),
                _field(_otpCtrl, "OTP via HP/Email"),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700], minimumSize: const Size(double.infinity, 50)),
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
                        setState(()=> _isAdminStage2 = true);
                        return;
                      }
                    }
                  } catch (e) {
                    if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text(_isDaftar? "DAFTAR (Wajib Referral)" : "LOGIN", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: ()=> setState(()=> _isDaftar =!_isDaftar),
                child: Text(_isDaftar? "Sudah punya akun? Login" : "Pengguna baru? Daftar isi kode referral", style: const TextStyle(color: Colors.amber)),
              )
            ] else...[
              const Text("LOGIN ADMIN TAHAP 2", style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text("Masukkan Sandi 2 & 3", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              _field(_adminPass2Ctrl, "Sandi 2", isPass: true, obscure: true),
              const SizedBox(height: 12),
              _field(_adminPass3Ctrl, "Sandi 3", isPass: true, obscure: true),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700], minimumSize: const Size(double.infinity, 50)),
                onPressed: () async {
                  try {
                    final ok = await _auth.adminStage2(_adminPass2Ctrl.text, _adminPass3Ctrl.text);
                    if (ok && mounted) Navigator.pushReplacementNamed(context, '/admin');
                  } catch (e) {
                    if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: const Text("MASUK PANEL ADMIN", style: TextStyle(color: Colors.black)),
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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true, fillColor: Colors.grey[900],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        // INI FIX ERROR KAMU - SEBELUMNYA KURANG onPressed
        suffixIcon: isPass? IconButton(
          icon: Icon(obscure? Icons.visibility_off : Icons.visibility, color: Colors.amber),
          onPressed: toggle,
        ) : null,
      ),
    );
  }
}
