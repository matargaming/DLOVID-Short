import 'package:flutter/material.dart';
import '../main/main_navigation.dart';
import '../admin/admin_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  bool isRegister = false;
  bool showPass = false;
  bool showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Image.asset('assets/logo_login.png', height: 120, errorBuilder: (c,e,s)=> const Icon(Icons.movie, size: 100, color: Colors.amber)),
            const SizedBox(height: 20),
            const Text('DLOVID-Short', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 30),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email / No HP', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
            const SizedBox(height: 12),
            TextField(controller: passCtrl, obscureText: !showPass, decoration: InputDecoration(labelText: 'Sandi', border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.lock), suffixIcon: IconButton(icon: Icon(showPass? Icons.visibility: Icons.visibility_off), onPressed: ()=> setState(()=> showPass=!showPass)))),
            if(isRegister) ...[
              const SizedBox(height: 12),
              TextField(controller: confirmCtrl, obscureText: !showConfirm, decoration: InputDecoration(labelText: 'Confirm Sandi', border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.lock_outline), suffixIcon: IconButton(icon: Icon(showConfirm? Icons.visibility: Icons.visibility_off), onPressed: ()=> setState(()=> showConfirm=!showConfirm)))),
            ],
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, padding: const EdgeInsets.all(16)), onPressed: (){
              if(emailCtrl.text.trim() == 'matargaming17@gmail.com' && passCtrl.text == 'Bosmatar123.321'){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> const AdminLoginScreen()));
                return;
              }
              if(emailCtrl.text.isEmpty || passCtrl.text.length < 6){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No HP/Email atau sandi tidak sesuai')));
                return;
              }
              if(isRegister && passCtrl.text != confirmCtrl.text){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Confirm sandi tidak sama')));
                return;
              }
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const MainNavigation()));
            }, child: Text(isRegister? 'DAFTAR + OTP':'LOGIN'))),
            TextButton(onPressed: ()=> setState(()=> isRegister=!isRegister), child: Text(isRegister? 'Sudah punya akun? Login' : 'Belum punya akun? Daftar (OTP HP/Email)')),
          ],
        ),
      ),
    );
  }
}
