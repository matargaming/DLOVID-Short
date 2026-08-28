import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../admin/admin_home.dart';
import '../user/user_home.dart';

class LoginGate extends StatefulWidget {
  const LoginGate({super.key});
  @override State<LoginGate> createState() => _LoginGateState();
}

class _LoginGateState extends State<LoginGate> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _referral = TextEditingController();
  final _adminEmail = "matargaming17@gmail.com";

  bool _isLogin = true;
  bool _loading = false;

  void _showError(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  Future<void> _proses() async {
    if(_email.text.trim().isEmpty || _pass.text.trim().isEmpty){
      _showError("Isi Email & Sandi"); return;
    }
    setState(() => _loading = true);
    try{
      if(_isLogin){
        // LOGIN REAL
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text.trim(), password: _pass.text.trim());
        final uid = FirebaseAuth.instance.currentUser!.uid;
        final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if(!doc.exists){
          _showError("User tidak ada di Firestore");
          return;
        }
        final data = doc.data()!;
        if(data['status'] == 'PENDING'){
          _showError("Menunggu Approve Admin");
          return;
        }
        if(_email.text.trim() == _adminEmail || data['role'] == 'admin'){
          if(!mounted) return;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminHome()));
        } else {
          if(!mounted) return;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserHome()));
        }
      } else {
        // DAFTAR REAL - PENDING
        if(_referral.text.trim().isEmpty){
          _showError("Kode Referral Wajib!"); return;
        }
        final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text.trim(), password: _pass.text.trim());
        await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
          'email': _email.text.trim(),
          'kode_referral_input': _referral.text.trim().toUpperCase(),
          'level': 'MEMBER',
          'status': 'PENDING',
          'createdAt': FieldValue.serverTimestamp(),
          'isVip': false,
          'saldo': 0,
        });
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Daftar Sukses - PENDING Menunggu Approve Admin di HOME"), backgroundColor: Colors.green));
        setState(() => _isLogin = true);
      }
    } on FirebaseAuthException catch(e){
      _showError(e.message ?? "Auth Error");
    } finally {
      if(mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("DLOVID SHORT", style: TextStyle(color: Colors.amber.shade700, fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        TextField(controller: _email, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Email", labelStyle: TextStyle(color: Colors.white38))),
        TextField(controller: _pass, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Sandi", labelStyle: TextStyle(color: Colors.white38))),
        if(!_isLogin) TextField(controller: _referral, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Kode Referral (Wajib DVS0000 / DLOVID-XXXX)", labelStyle: TextStyle(color: Colors.white38))),
        const SizedBox(height: 20),
        _loading ? const CircularProgressIndicator(color: Colors.amber) : SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _proses, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700), child: Text(_isLogin ? "LOGIN" : "DAFTAR PENDING", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
        TextButton(onPressed: () => setState(() => _isLogin = !_isLogin), child: Text(_isLogin ? "Belum punya akun? Daftar" : "Sudah punya akun? Login", style: const TextStyle(color: Colors.white38))),
      ]))),
    );
  }
}
