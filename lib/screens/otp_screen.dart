import 'package:flutter/material.dart';
class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("OTP via HP/Email")), body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [Text("OTP dikirim ke $email"), const SizedBox(height:20), const TextField(decoration: InputDecoration(labelText:"Kode OTP", border: OutlineInputBorder())), const SizedBox(height:20), ElevatedButton(onPressed: ()=>Navigator.pop(context), child: const Text("Verifikasi"))])));
  }
}
