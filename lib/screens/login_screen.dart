import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_screen.dart';
import 'admin/admin_login_1.dart';
import '../main_navigation.dart';

class LoginScreen extends StatefulWidget {
  final bool isTablet;
  const LoginScreen({super.key, required this.isTablet});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  bool obscure1 = true, obscure2 = true;
  bool isLogin = true;

  void login() async {
    String email = emailCtrl.text.trim();
    String pass = passCtrl.text.trim();
    String adminEmail = dotenv.env['ADMIN_EMAIL']?? '';
    String adminKey1 = dotenv.env['ADMIN_KEY_1']?? '';
    if (email == adminEmail && pass == adminKey1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLogin1()));
      return;
    }
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      } else {
        if (pass!= confirmCtrl.text) throw "Confirm tidak cocok";
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
        Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(email: email)));
        return;
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainNavigation(isTablet: widget.isTablet)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ditolak: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: widget.isTablet? 500 : double.infinity,
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/logo_login.png', height: 100, errorBuilder: (_,__,___) => const Icon(Icons.play_circle, size: 80, color: Colors.red)),
            const Text("DLOVID SHORT", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red)),
            const SizedBox(height: 20),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "Email / No HP", border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: passCtrl, obscureText: obscure1, decoration: InputDecoration(labelText: "Sandi", border: const OutlineInputBorder(), suffixIcon: IconButton(icon: Icon(obscure1?Icons.visibility_off:Icons.visibility), onPressed: ()=>setState(()=>obscure1=!obscure1)))),
            const SizedBox(height: 12),
            if (!isLogin) TextField(controller: confirmCtrl, obscureText: obscure2, decoration: InputDecoration(labelText: "Confirm Sandi", border: const OutlineInputBorder(), suffixIcon: IconButton(icon: Icon(obscure2?Icons.visibility_off:Icons.visibility), onPressed: ()=>setState(()=>obscure2=!obscure2)))),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: login, child: Text(isLogin?"LOGIN":"DAFTAR + OTP"))),
            TextButton(onPressed: ()=>setState(()=>isLogin=!isLogin), child: Text(isLogin?"Belum punya akun? Daftar":"Sudah punya akun? Login")),
          ]),
        ),
      ),
    );
  }
}
