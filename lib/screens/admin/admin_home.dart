import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  @override State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: [const HomeTab(), const UploadTab(), const UserTab()][idx],
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
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text("PANEL ADMIN - HOME", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // a. Kotak live monitor pengguna baru
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("a. Kotak live monitor pengguna baru", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').where('status', isEqualTo: 'PENDING').orderBy('createdAt', descending: true).snapshots(),
              builder: (c,s){
                if(!s.hasData) return const Text("Loading...", style: TextStyle(color: Colors.white38));
                return Column(children: s.data!.docs.map((d){
                  final data = d.data() as Map<String,dynamic>;
                  return ListTile(
                    dense: true,
                    title: Text("${data['email']} - ${data['kode_referral_input']}", style: const TextStyle(color: Colors.white, fontSize: 12)),
                    subtitle: Text("Status: PENDING - Menunggu Approve", style: const TextStyle(color: Colors.white38, fontSize: 10)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      ElevatedButton(onPressed: () => FirebaseFirestore.instance.collection('users').doc(d.id).update({'status':'ACTIVE','kode_referral_saya': 'DLOVID-${d.id.substring(0,4).toUpperCase()}'}), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(50,30)), child: const Text("Setuju", style: TextStyle(fontSize: 10))),
                      const SizedBox(width: 6),
                      ElevatedButton(onPressed: () => FirebaseFirestore.instance.collection('users').doc(d.id).update({'status':'REJECT'}), style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(50,30)), child: const Text("Tolak", style: TextStyle(fontSize: 10))),
                    ]),
                  );
                }).toList());
              }
            ),
          ]),
        ),
        const SizedBox(height: 16),
        // b. Kolase Film terlaris
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("b. Kolase Film terlaris yang sering di tonton member", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('videos').where('status', isEqualTo: 'approved').orderBy('views', descending: true).limit(10).snapshots(),
              builder: (c,s){
                if(!s.hasData) return const Text("Loading...", style: TextStyle(color: Colors.white38));
                return SizedBox(height: 120, child: ListView(scrollDirection: Axis.horizontal, children: s.data!.docs.map((d){
                  final data = d.data() as Map<String,dynamic>;
                  return Container(width: 100, margin: const EdgeInsets.only(right: 8), color: Colors.grey.shade900, child: Center(child: Text("${data['views']??0} views", style: const TextStyle(color: Colors.white, fontSize: 10))));
                }).toList()));
              }
            ),
          ]),
        ),
      ]),
    );
  }
}

// 2. UPLOAD
class UploadTab extends StatelessWidget {
  const UploadTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text("PANEL ADMIN - UPLOAD", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("a. Kotak Upload film yang bisa di ambil dari galeri hp", style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text("b. Kotak otomatis AI koreksi film copyright atau tidak yang di upload dari galeri hp", style: TextStyle(color: Colors.white70, fontSize: 12)),
          SizedBox(height: 12),
          Text("c. Kotak upload yang bisa pakai link", style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text("d. Kotak otomatis AI koreksi film copyright atau tidak yang di upload dari Link", style: TextStyle(color: Colors.white70, fontSize: 12)),
        ])),
        const SizedBox(height: 12),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('videos').where('status', isEqualTo: 'pending_admin').snapshots(),
          builder: (c,s){
            if(!s.hasData) return const Text("Tidak ada video pending", style: TextStyle(color: Colors.white38));
            return Column(children: s.data!.docs.map((d){
              final data = d.data() as Map<String,dynamic>;
              return Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Video dari: ${data['uploaderUid']}", style: const TextStyle(color: Colors.white, fontSize: 12)),
                Text("e. Pengguna SUPERVISOR sd SULTAN - Menu upload aktif di pengguna: ${data['uploaderLevel']??''}", style: const TextStyle(color: Colors.amber, fontSize: 11)),
                Text("f. Seleksi admin pake AI apakah copyright atau tidak: ${data['aiResult']?['reason']??''}", style: const TextStyle(color: Colors.white70, fontSize: 11)),
                Text("g. Pengguna SUPERVISOR sd SULTAN dapat pembagian bonus dari iklan 50:50", style: const TextStyle(color: Colors.green, fontSize: 11)),
                const SizedBox(height: 8),
                Row(children: [
                  ElevatedButton(onPressed: () => FirebaseFirestore.instance.collection('videos').doc(d.id).update({'status':'approved'}), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("Setujui")),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: () => FirebaseFirestore.instance.collection('videos').doc(d.id).update({'status':'rejected'}), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Tolak")),
                ]),
              ]));
            }).toList());
          }
        ),
      ]),
    );
  }
}

// 3. USER
class UserTab extends StatelessWidget {
  const UserTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text("PANEL ADMIN - USER", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text("a. Kotak data total pengguna sesuai level urutan dari", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('users').snapshots(), builder: (c,s){
          if(!s.hasData) return const Text("Loading...", style: TextStyle(color: Colors.white38));
          final docs = s.data!.docs;
          int countLevel(String level) => docs.where((d) => (d.data() as Map)['level']==level).length;
          return Column(children: [
            _levelBox("MEMBER", countLevel("MEMBER")),
            _levelBox("MEMBER AKTIF", countLevel("MEMBER AKTIF")),
            _levelBox("TEAM LEADER", countLevel("TEAM LEADER")),
            _levelBox("SUPERVISOR", countLevel("SUPERVISOR")),
            _levelBox("GENERAL", countLevel("GENERAL")),
            _levelBox("WAKIL SULTAN", countLevel("WAKIL SULTAN")),
            _levelBox("SULTAN", countLevel("SULTAN")),
          ]);
        }),
        const SizedBox(height: 16),
        const Text("b. kotak pengguna yang mau WD ada tulisan tolak, setuju", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('wd_requests').where('status', isEqualTo: 'PENDING').snapshots(), builder: (c,s){
          if(!s.hasData) return const Text("Tidak ada WD", style: TextStyle(color: Colors.white38));
          return Column(children: s.data!.docs.map((d){
            final data = d.data() as Map<String,dynamic>;
            return Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("${data['email']} - Rp ${data['nominal']}", style: const TextStyle(color: Colors.white, fontSize: 12)), Text("${data['level']}", style: const TextStyle(color: Colors.white38, fontSize: 10))])),
              ElevatedButton(onPressed: () => FirebaseFirestore.instance.collection('wd_requests').doc(d.id).update({'status':'APPROVED'}), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(60,30)), child: const Text("Setuju", style: TextStyle(fontSize: 10))),
              const SizedBox(width: 6),
              ElevatedButton(onPressed: () => FirebaseFirestore.instance.collection('wd_requests').doc(d.id).update({'status':'REJECTED'}), style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(60,30)), child: const Text("Tolak", style: TextStyle(fontSize: 10))),
            ]));
          }).toList());
        }),
      ]),
    );
  }
  static Widget _levelBox(String level, int count) => Container(margin: const EdgeInsets.only(bottom: 6), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(8)), child: Row(children: [Text(level, style: const TextStyle(color: Colors.white, fontSize: 12)), const Spacer(), Text("= $count", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))]));
}
