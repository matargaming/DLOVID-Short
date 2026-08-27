import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BonusScreen extends StatefulWidget {
  @override
  _BonusScreenState createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  int coins = 1250;
  bool canClaim = false;
  int purchased = 0;

  @override
  void initState(){
    super.initState();
    checkClaimTime(); // Point 6: nyala jam 12.00, hangus 13.00
  }

  checkClaimTime(){
    final now = DateTime.now();
    if(now.hour==12) setState(()=> canClaim=true);
    if(now.hour>=13) setState(()=> canClaim=false);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // 1. Daftar pengguna pendapatan tertinggi 1-100
          _box(title: "Top 100 Pendapatan", onTap: ()=> showTop100(), icon: Icons.leaderboard),
          // 2. Iklan live undang orang dapat koin
          _boxLiveUndang(),
          // 3. Level syarat naik level harus beli paket
          _box(title: "Level Saat Ini: 1 - Beli Paket Untuk Naik Level", color: Colors.amber[700]),
          // 4. Kode referral + icon WA
          _boxReferralWa(),
          // 5. Riwayat dukung AI + member
          _box(title: "Riwayat Dukung - 5 AI - Member Gold", onTap: (){}),
          // 6. Jumlah koin + claim jam 12.00
          _boxClaim(),
          // 7. Live investasi
          _box(title: "Live Investasi: Rp 2.540.000 masuk dari user ***123", color: Colors.green[900]),
          // 8. 1 koin = 15.00
          Container(padding: EdgeInsets.all(12), color: Colors.grey[900], child: Text("1 Koin = Rp 15.00", style: TextStyle(color: Colors.amber))),
          SizedBox(height: 12),
          // 9. Kotak AI
          _boxAI(),
          // 10. Aturan penarikan
          _boxAturan(),
          // 11. Penghasilan yang pernah didapat
          _box(title: "Penghasilan Pernah Didapat: Rp 1.250.000", color: Colors.grey[900]),
        ],
      ),
    );
  }

  Widget _boxAI(){
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(children: [
            Icon(Icons.smart_toy, color: Colors.amber, size: 40),
            SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("AI Supporter - DLOVID AI", style: TextStyle(color: Colors.white)),
              Text("Jumlah Dukungan: 50", style: TextStyle(color: Colors.white70, fontSize: 12)),
            ])
          ]),
          SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Hadiah Tetap", style: TextStyle(color: Colors.white70)), Text("3%", style: TextStyle(color: Colors.amber)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Periode Pendapatan", style: TextStyle(color: Colors.white70)), Text("360 Hari", style: TextStyle(color: Colors.white)),
          ]),
          SizedBox(height: 8),
          Row(children: [
            Text("Batas Pembelian $purchased/3", style: TextStyle(color: Colors.white)),
            Spacer(),
            IconButton(icon: Icon(Icons.remove, color: Colors.white), onPressed: ()=> setState(()=> purchased = (purchased>0)?purchased-1:0)),
            Text("$purchased", style: TextStyle(color: Colors.white)),
            IconButton(icon: Icon(Icons.add, color: Colors.white), onPressed: ()=> setState(()=> purchased = (purchased<3)?purchased+1:3)),
          ])
        ],
      ),
    );
  }

  Widget _boxClaim(){
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: canClaim? Colors.amber[700] : Colors.grey[800], borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Koin: $coins", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: canClaim? (){
              // Claim uang langsung hilang masuk dompet toolbar akun
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Claim berhasil - Masuk Dompet Akun!")));
              setState(()=> coins=0);
            } : null,
            child: Text(canClaim? "CLAIM SEKARANG (12.00-13.00)" : "Tutup Jam 13.00 Hangus"),
          )
        ],
      ),
    );
  }

  Widget _boxReferralWa(){
    return Container(
      padding: EdgeInsets.all(12), color: Colors.grey[900],
      child: Row(
        children: [
          Text("Kode: BOSMATAR-ROOT-001", style: TextStyle(color: Colors.white)),
          Spacer(),
          IconButton(icon: Icon(Icons.chat, color: Colors.green), onPressed: () async {
            final waUrl = "https://wa.me/6287810865333?text=Kode referral saya: BOSMATAR-ROOT-001";
            await launchUrl(Uri.parse(waUrl));
          })
        ],
      ),
    );
  }

  Widget _boxLiveUndang(){
    return Container(height: 40, color: Colors.black, child: ListView(scrollDirection: Axis.horizontal, children: [
      Text("🔴 LIVE: User Andi undang 3 orang dapat 3000 koin - ", style: TextStyle(color: Colors.green)),
      Text("User Budi undang 1 orang dapat 1000 koin - ", style: TextStyle(color: Colors.green)),
    ]));
  }

  Widget _box({required String title, Color? color, VoidCallback? onTap, IconData? icon}){
    return GestureDetector(
      onTap: onTap,
      child: Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color?? Colors.grey[900], borderRadius: BorderRadius.circular(12)), child: Row(children: [if(icon!=null) Icon(icon, color: Colors.amber), SizedBox(width: 8), Expanded(child: Text(title, style: TextStyle(color: Colors.white)))])),
    );
  }

  Widget _boxAturan(){
    return Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Aturan Penarikan:", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      Text("1. Claim bonus setiap jam 12.00 ketika jam 13.00 akan hangus bonusnya/kosong.\n2. Selesai masa kontrak AI modal dikembalikan", style: TextStyle(color: Colors.white70, fontSize: 12)),
    ]));
  }

  void showTop100(){
    showDialog(context: context, builder: (c)=> AlertDialog(title: Text("Top 100"), content: Container(height: 300, child: ListView.builder(itemCount: 100, itemBuilder: (c,i)=> ListTile(title: Text("User ${i+1} - Rp ${(100-i)*10000}"))))));
  }
}
