import 'package:flutter/material.dart';
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('PANEL ADMIN - DLOVID'), backgroundColor: Colors.red),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(color: Colors.grey[900], child: const ListTile(title: Text('Kotak Live Iklan Ditonton'), subtitle: Text('1,234 views - Rp 1.2jt'), leading: Icon(Icons.monetization_on, color: Colors.amber))),
          Card(color: Colors.grey[900], child: const ListTile(title: Text('Daftar Trending TMDB'), subtitle: Text('Atur urutan drama'), leading: Icon(Icons.trending_up))),
          Card(color: Colors.grey[900], child: const ListTile(title: Text('User Live'), subtitle: Text('12 live - Tegur/Blokir'), leading: Icon(Icons.live_tv, color: Colors.red))),
          Card(color: Colors.grey[900], child: const ListTile(title: Text('Moderasi Video Pendek'), subtitle: Text('45 video pending'), leading: Icon(Icons.video_library))),
          Card(color: Colors.grey[900], child: const ListTile(title: Text('Pendapatan + WD'), subtitle: Text('WD User Potongan 20% Admin'), leading: Icon(Icons.account_balance_wallet))),
        ],
      ),
    );
  }
}
