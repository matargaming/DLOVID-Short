import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  @override State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int idx = 0;
  final tabs = const [HomeTab(), UploadTab(), UserTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: tabs[idx],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white38,
        currentIndex: idx,
        onTap: (i) => setState(() => idx = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: "UPLOAD"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "USER"),
        ],
      ),
    );
  }
}

// 1. HOME
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [
        Row(children: [Image.asset('assets/images/logo_login.png', width: 40, height: 40, errorBuilder: (_,__,___)=> const Icon(Icons.play_circle, color: Colors.amber, size: 40)), const SizedBox(width: 10), const Text("HOME ADMIN", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))]),
        const SizedBox(height: 16),
        // a
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("1.a Kotak live monitor pengguna baru", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 10),
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)), child: Row(children: [
            const Expanded(child: Text("matargaming17@gmail.com\nPakai DVS0000 - 2 menit lalu\nStatus: PENDING", style: TextStyle(color: Colors.white, fontSize: 11))),
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(60,30)), child: const Text("Setuju", style: TextStyle(fontSize: 10))),
            const SizedBox(width: 5),
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(60,30)), child: const Text("Tolak", style: TextStyle(fontSize: 10))),
          ])),
        ])),
        const SizedBox(height: 16),
        // b
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("1.b Kolase Film terlaris yang sering di tonton member", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 10),
          SizedBox(height: 100, child: ListView(scrollDirection: Axis.horizontal, children: [for (var i=1;i<=5;i++) Container(width: 80, margin: const EdgeInsets.only(right: 8), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)), child: Center(child: Text("Film $i\n${10*i}K views", textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 10))))])),
        ])),
      ])),
    );
  }
}

// 2. UPLOAD
class UploadTab extends StatelessWidget {
  const UploadTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text("2. UPLOAD - SESUAI G", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _kotak("a. Kotak Upload film yang bisa di ambil dari galeri hp", Icons.photo_library, "Pilih dari Galeri HP"),
        _kotak("b. Kotak otomatis AI koreksi film copyright atau tidak yang di upload dari galeri hp", Icons.smart_toy, "AI CHECK: Scanning Copyright... 98% Safe - TMDB_API_KEY OK", isAI: true),
        _kotak("c. Kotak upload yang bisa pakai link", Icons.link, "Tempel Link Film"),
        _kotak("d. Kotak otomatis AI koreksi film copyright atau tidak yang di upload dari Link", Icons.smart_toy, "AI CHECK Link: No Copyright", isAI: true),
        _kotak("e. Kotak untuk pengguna yang sudah SUPERVISOR sd SULTAN kotak di menu upload video aktif di pengguna aktif", Icons.verified_user, "SUPERVISOR - SULTAN : Upload Aktif", isGold: true),
        _kotak("f. Seleksi admin pake AI apakah copyright atau tidak", Icons.security, "Admin AI Selector: Manual + AI TMDB"),
        // g & h - INI YANG BARU BOS TAMBAH
        Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("g. Kotak pengguna yang sedang upload film langsung masuk ke panel admin ada tombol disetujui admin atau tidak", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)), child: Row(children: [
            const Expanded(child: Text("User: supervisor_user@gmail.com\nLevel: SUPERVISOR\nJudul: Fast & Furious Clip\nStatus: Menunggu Approve", style: TextStyle(color: Colors.white70, fontSize: 11))),
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("Disetujui")),
            const SizedBox(width: 6),
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Tidak")),
          ])),
          const SizedBox(height: 10),
          const Text("h. Ada AI yang seleksi film yang di upload pengguna copyright atau tidak", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 6),
          const Text("AI Result: ✅ No Copyright (Original Content) - Score 92% - TMDB Check OK - Siap Tayang", style: TextStyle(color: Colors.green, fontSize: 11)),
        ])),
      ])),
    );
  }
  static Widget _kotak(String title, IconData icon, String content, {bool isAI=false, bool isGold=false}) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, color: isAI?Colors.greenAccent: isGold?Colors.amber:Colors.white, size: 18), const SizedBox(width: 8), Expanded(child: Text(title, style: TextStyle(color: isGold?Colors.amber:Colors.white, fontWeight: FontWeight.bold, fontSize: 11))) ]), const SizedBox(height: 8), Text(content, style: TextStyle(color: isAI?Colors.greenAccent:Colors.white54, fontSize: 11))]));
}

// 3. USER
class UserTab extends StatelessWidget {
  const UserTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text("3. USER", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Text("a. Kotak data total pengguna sesuai level", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        _level("MEMBER", "450"), _level("MEMBER AKTIF", "120"), _level("TEAM LEADER", "30"), _level("SUPERVISOR", "15"), _level("GENERAL", "5"), _level("WAKIL SULTAN", "2"), _level("SULTAN", "1"),
        const SizedBox(height: 16),
        const Text("b. kotak pengguna yang mau WD ada tulisan tolak, setuju", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Expanded(child: Text("user_aktif@gmail.com - Rp 500.000\nWD Bonus Referral", style: TextStyle(color: Colors.white, fontSize: 11))), ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(60,30)), child: const Text("Setuju", style: TextStyle(fontSize: 10))), const SizedBox(width: 6), ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(60,30)), child: const Text("Tolak", style: TextStyle(fontSize: 10)))])),
      ])),
    );
  }
  static Widget _level(String l, String c) => Container(margin: const EdgeInsets.only(bottom: 5), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(8)), child: Row(children: [Text(l, style: const TextStyle(color: Colors.white, fontSize: 12)), const Spacer(), Text("= $c", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))]));
}
