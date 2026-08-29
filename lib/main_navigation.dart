import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class MainNavigation extends StatefulWidget {
  final bool isTablet;
  const MainNavigation({super.key, required this.isTablet});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}
class _MainNavigationState extends State<MainNavigation> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [const Beranda(), const Center(child: Text("Drama - pakai drama_screen.dart")), const SizedBox(), const Pesan(), Akun(isTablet: widget.isTablet)][current],
      bottomNavigationBar: NavigationBar(selectedIndex: current, onDestinationSelected: (i){ if(i==2){ showModalBottomSheet(context: context, builder: (_)=> const PlusSheet()); return; } setState(()=>current=i); }, destinations: const [NavigationDestination(icon: Icon(Icons.home), label:"Beranda"), NavigationDestination(icon: Icon(Icons.movie), label:"Drama"), NavigationDestination(icon: Icon(Icons.add_box, size:32), label:""), NavigationDestination(icon: Icon(Icons.message), label:"Pesan"), NavigationDestination(icon: Icon(Icons.person), label:"Akun")]),
    );
  }
}
class Beranda extends StatelessWidget { const Beranda({super.key}); @override Widget build(BuildContext context) { return PageView.builder(scrollDirection: Axis.vertical, itemCount: 10, itemBuilder: (_,i)=> Container(color: Colors.black, child: Center(child: Text("Live/Upload $i", style: const TextStyle(color: Colors.white))))); } }
class Pesan extends StatelessWidget { const Pesan({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text("Pesan - TikTok Style")), body: ListView.builder(itemCount: 20, itemBuilder: (_,i)=> ListTile(leading: const CircleAvatar(), title: Text("User $i")))); } }
class PlusSheet extends StatelessWidget { const PlusSheet({super.key}); @override Widget build(BuildContext context) { return Container(padding: const EdgeInsets.all(20), height: 200, child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Column(children: [IconButton(icon: const Icon(Icons.live_tv, size:40), onPressed: (){ String key = dotenv.env['MIDTRANS_CLIENT_KEY']??''; showDialog(context: context, builder: (_)=> AlertDialog(title: const Text("VIP Required 30k"), content: Text("Midtrans: $key"), actions: [TextButton(onPressed: (){}, child: const Text("Beli QRIS"))])); }), const Text("Live")]), Column(children: [IconButton(icon: const Icon(Icons.upload, size:40), onPressed: (){}), const Text("Upload")])])); } }
class Akun extends StatelessWidget { final bool isTablet; const Akun({super.key, required this.isTablet}); @override Widget build(BuildContext context) { return Scaffold(body: ListView(padding: EdgeInsets.all(isTablet?32:16), children: [Row(children: [CircleAvatar(radius: isTablet?50:35, child: const Icon(Icons.person)), const SizedBox(width:15), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Text("Nama Pengguna", style: TextStyle(fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.edit, size:16), onPressed: (){})]), Row(children: [const Text("Foto"), IconButton(icon: const Icon(Icons.edit, size:16), onPressed: (){})])]))]), Card(child: ListTile(title: const Text("Pendapatan Koin"), trailing: IconButton(icon: const Icon(Icons.currency_exchange), onPressed: (){}))), Card(child: ListTile(title: const Text("Dompet"), subtitle: const Text("Rp 125.000"), leading: const Icon(Icons.wallet))), Card(child: ListTile(title: const Text("WD Wallet/Bank - Potongan 20%"), trailing: ElevatedButton(onPressed: (){ int wd=100000; int pot=(wd*0.2).toInt(); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("WD $wd pot $pot terima ${wd-pot}"))); }, child: const Text("WD")))), const Card(color: Colors.amber, child: ListTile(title: Text("VIP 1 Bulan 30.000 - QRIS"), leading: Icon(Icons.qr_code))) ])); } }
