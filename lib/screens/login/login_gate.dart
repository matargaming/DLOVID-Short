import 'package:flutter/material.dart';
import '../admin/admin_home.dart';
import '../user/user_home.dart';

class LoginGate extends StatefulWidget {
  const LoginGate({super.key});
  @override State<LoginGate> createState() => _LoginGateState();
}

class _LoginGateState extends State<LoginGate> {
  final _email = TextEditingController(text: "matargaming17@gmail.com");
  final _pass = TextEditingController(text: "Bosmatar123.321");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("DLOVID SHORT", style: TextStyle(color: Colors.amber, fontSize: 28, fontWeight: FontWeight.bold)),
        TextField(controller: _email, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Email")),
        TextField(controller: _pass, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Sandi")),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: (){
          if(_email.text.trim() == "matargaming17@gmail.com"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminHome()));
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserHome()));
          }
        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700), child: const Text("LOGIN", style: TextStyle(color: Colors.black)))),
      ]))),
    );
  }
}
