import 'package:flutter/material.dart';
import 'admin_dashboard.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});
  @override
  State<AdminLoginScreen> createState()=> _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen>{
  final s1 = TextEditingController();
  final s2 = TextEditingController();
  bool show1=false, show2=false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Login Admin Level 2'), backgroundColor: Colors.red),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Petunjuk: Masukkan 2 Sandi Terakhir', style: TextStyle(color: Colors.amber)),
            const SizedBox(height: 20),
            TextField(controller: s1, obscureText: !show1, decoration: InputDecoration(labelText: 'Sandi 1: Bosmatar456.654', border: const OutlineInputBorder(), suffixIcon: IconButton(icon: Icon(show1? Icons.visibility: Icons.visibility_off), onPressed: ()=> setState(()=> show1=!show1)))),
            const SizedBox(height: 12),
            TextField(controller: s2, obscureText: !show2, decoration: InputDecoration(labelText: 'Sandi 2: Bosmatar21100169830188', border: const OutlineInputBorder(), suffixIcon: IconButton(icon: Icon(show2? Icons.visibility: Icons.visibility_off), onPressed: ()=> setState(()=> show2=!show2)))),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: (){
              if(s1.text=='Bosmatar456.654' && s2.text=='Bosmatar21100169830188'){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const AdminDashboard()));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sandi Admin Salah')));
              }
            }, child: const Text('LOGIN ADMIN'))),
          ],
        ),
      ),
    );
  }
}
