import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class AdminLogin1 extends StatefulWidget {
  const AdminLogin1({super.key});
  @override
  State<AdminLogin1> createState() => _AdminLogin1State();
}
class _AdminLogin1State extends State<AdminLogin1> {
  final k2 = TextEditingController(); final k3 = TextEditingController();
  void verify(){
    if(k2.text == dotenv.env['ADMIN_KEY_2'] && k3.text == dotenv.env['ADMIN_KEY_3']){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const AdminDashboard()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sandi 2 & 3 salah!")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("ADMIN - 2 Sandi Lagi")), body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [TextField(controller: k2, obscureText: true, decoration: const InputDecoration(labelText:"ADMIN_KEY_2", border: OutlineInputBorder())), const SizedBox(height:12), TextField(controller: k3, obscureText: true, decoration: const InputDecoration(labelText:"ADMIN_KEY_3", border: OutlineInputBorder())), const SizedBox(height:20), SizedBox(width: double.infinity, height:50, child: ElevatedButton(onPressed: verify, child: const Text("MASUK DASHBOARD")))])));
  }
}
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("DLOVID ADMIN PANEL")), body: ListView(padding: const EdgeInsets.all(16), children: const [Card(child: ListTile(title: Text("Live Iklan Ditonton"), leading: Icon(Icons.monetization_on))), Card(child: ListTile(title: Text("Trending TMDB"), leading: Icon(Icons.trending_up))), Card(child: ListTile(title: Text("Pendapatan Admin 20%"), leading: Icon(Icons.wallet))), Card(child: ListTile(title: Text("WD Admin Bank/Wallet"), leading: Icon(Icons.payments))), Card(child: ListTile(title: Text("Monitor Live - Tegur/Blokir"), leading: Icon(Icons.report))) ]));
  }
}
