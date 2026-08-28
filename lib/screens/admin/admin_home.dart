import 'package:flutter/material.dart';
import 'dart:math';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  @override State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _idx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: [const AdminHomeTab(), const AdminUploadTab(), const AdminUserTab()][_idx],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, selectedItemColor: Colors.amber.shade700,
        unselectedItemColor: Colors.white38, currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i), type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: "UPLOAD"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "USER"),
        ],
      ),
    );
  }
}

// ================= HOME =================
class AdminHomeTab extends StatelessWidget {
  const AdminHomeTab({super.key});
  @override Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text("PANEL ADMIN DLOVID", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        // a. Live Monitor Pengguna Baru
        Container(decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [Icon(Icons.live_tv, color: Colors.red, size: 18), SizedBox(width: 6), Text("Live Monitor Pengguna Baru", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
            const SizedBox(height: 8),
            _liveTile("user_baru@gmail.com", "MEMBER", "Referral: DVS0000 - 2 menit lalu", Colors.green),
            _liveTile("member_aktif12@gmail.com", "MEMBER AKTIF", "Referral: DLOVID-AB12 - 10 menit lalu", Colors.blue),
            _liveTile("supervisor_jaya@gmail.com", "SUPERVISOR", "Naik Level - 1 jam lalu", Colors.amber),
          ]),
        ),
        const SizedBox(height: 16),
        // b. Kolase Film Terlaris
        const Text("Kolase Film Terlaris (Sering Ditonton Member)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(height: 160, child: ListView(scrollDirection: Axis.horizontal, children: [
          _filmCard("Sultan Movie 1", "12.5K views"),
          _filmCard("Team Leader Series", "9.2K views"),
          _filmCard("General Action", "8.1K views"),
          _filmCard("Wakil Sultan Drama", "7.5K views"),
        ])),
      ]),
    );
  }
  static Widget _liveTile(String email, String level, String sub, Color c) => ListTile(dense: true, leading: CircleAvatar(backgroundColor: c, radius: 8), title: Text("$email - $level", style: const TextStyle(color: Colors.white, fontSize: 12)), subtitle: Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 10)));
  static Widget _filmCard(String title, String views) => Container(width: 110, margin: const EdgeInsets.only(right: 10), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: Column(children: [Container(height: 100, decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: const BorderRadius.vertical(top: Radius.circular(12)))), Padding(padding: const EdgeInsets.all(6), child: Column(children: [Text(title, maxLines: 1, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)), Text(views, style: const TextStyle(color: Colors.amber, fontSize: 9))]))]));
}

// ================= UPLOAD =================
class AdminUploadTab extends StatefulWidget {
  const AdminUploadTab({super.key});
  @override State<AdminUploadTab> createState() => _AdminUploadTabState();
}
class _AdminUploadTabState extends State<AdminUploadTab> {
  String _aiResult = "Belum di cek";
  Color _aiColor = Colors.white38;
  final _linkController = TextEditingController();

  void _cekAI() {
    // Simulasi AI Copyright Check
    final isCopyright = Random().nextBool();
    setState(() {
      if (isCopyright) { _aiResult = "COPYRIGHT TERDETEKSI - TOLAK"; _aiColor = Colors.red; }
      else { _aiResult = "AMAN - TIDAK COPYRIGHT"; _aiColor = Colors.green; }
    });
  }

  @override Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text("UPLOAD FILM", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        // a & b
        Container(decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("a. Upload dari Galeri HP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton.icon(onPressed: _cekAI, icon: const Icon(Icons.video_library), label: const Text("Pilih dari Galeri"), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700)),
            const SizedBox(height: 8),
            Text("b. AI Koreksi: $_aiResult", style: TextStyle(color: _aiColor, fontWeight: FontWeight.bold)),
          ]),
        ),
        const SizedBox(height: 12),
        // c & d
        Container(decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("c. Upload Pakai Link", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(controller: _linkController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: "Paste link Youtube/GDrive", hintStyle: const TextStyle(color: Colors.white38), filled: true, fillColor: Colors.black, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _cekAI, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700), child: const Text("Cek Link")),
            const SizedBox(height: 8),
            Text("d. AI Koreksi Link: $_aiResult", style: TextStyle(color: _aiColor, fontWeight: FontWeight.bold)),
          ]),
        ),
        const SizedBox(height: 12),
        // e, f, g
        Container(decoration: BoxDecoration(color: Colors.amber.shade700.withOpacity(0.15), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.amber.shade700)), padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("e. Khusus SUPERVISOR - SULTAN", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            const Text("Upload aktif hanya untuk level SUPERVISOR ke atas", style: TextStyle(color: Colors.white70, fontSize: 11)),
            const SizedBox(height: 8),
            const Text("f. Seleksi Admin + AI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Row(children: [
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("SETUJUI")),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("TOLAK")),
            ]),
            const SizedBox(height: 8),
            const Text("g. Bonus Iklan 50:50 untuk SUPERVISOR - SULTAN", style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
          ]),
        ),
      ]),
    );
  }
}

// ================= USER =================
class AdminUserTab extends StatelessWidget {
  const AdminUserTab({super.key});
  @override Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text("KELOLA USER & LEVEL", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        // a. Data total pengguna per level
        GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 2.2, crossAxisSpacing: 8, mainAxisSpacing: 8,
          children: [
            _levelCard("MEMBER", "450", Colors.grey),
            _levelCard("MEMBER AKTIF", "320", Colors.blue),
            _levelCard("TEAM LEADER", "80", Colors.lightBlue),
            _levelCard("SUPERVISOR", "25", Colors.amber),
            _levelCard("GENERAL", "10", Colors.orange),
            _levelCard("WAKIL SULTAN", "4", Colors.deepOrange),
            _levelCard("SULTAN", "1", Colors.amberAccent),
          ],
        ),
        const SizedBox(height: 16),
        const Text("b. Pengajuan WD (Withdraw)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _wdTile("supervisor_jaya@gmail.com", "SUPERVISOR", "Rp 2.500.000", "Bonus 50:50 Iklan"),
        _wdTile("sultan_top@gmail.com", "SULTAN", "Rp 15.000.000", "Bonus Sultan"),
        _wdTile("team_leader1@gmail.com", "TEAM LEADER", "Rp 500.000", "Bonus Referral"),
      ]),
    );
  }
  static Widget _levelCard(String level, String total, Color c) => Container(decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(10), border: Border.all(color: c.withOpacity(0.5))), padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(level, style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 11)), const Spacer(), Text("$total User", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]));
  static Widget _wdTile(String email, String level, String nominal, String ket) => Container(margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: ListTile(
    title: Text("$email - $level", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    subtitle: Text("$nominal - $ket", style: const TextStyle(color: Colors.white54, fontSize: 11)),
    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(60, 30)), child: const Text("Setuju", style: TextStyle(fontSize: 10))),
      const SizedBox(width: 6),
      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(60, 30)), child: const Text("Tolak", style: TextStyle(fontSize: 10))),
    ]),
  ));
}
