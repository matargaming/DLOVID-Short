import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AkunScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // 1. Frame foto bulat + pensil + UID + icon salin
          Row(children: [
            Stack(children: [
              CircleAvatar(radius: 40, backgroundImage: NetworkImage("https://i.pravatar.cc/150")),
              Positioned(bottom: 0, right: 0, child: CircleAvatar(radius: 12, backgroundColor: Colors.amber, child: Icon(Icons.edit, size: 14))),
            ]),
            SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Matar Gaming", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Row(children: [
                Text("No UID: 69830188", style: TextStyle(color: Colors.white70)),
                IconButton(icon: Icon(Icons.copy, color: Colors.amber, size: 16), onPressed: (){})
              ])
            ])
          ]),
          SizedBox(height: 16),
          // 2. Level pengguna
          Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.amber[700], borderRadius: BorderRadius.circular(12)), child: Text("Level Saat Ini: VIP 1")),
          SizedBox(height: 12),
          // 3. Pusat notifikasi telegram CS
          _itemAkun("Pusat Notifikasi - CS Telegram", onTap: () async {
            await launchUrl(Uri.parse("https://t.me/+6287810865333"));
          }),
          // 4. Grub chat bot
          _itemAkun("Grub Chat Bot - Posting Transfer & Iklan DLOVID"),
          // 5. Dompet + Top Up QRIS
          _dompetBox(),
          // 6. WD
          _itemAkun("WD - Penarikan ke Bank/Wallet", isWD: true),
          // 7. Status live penarikan
          Container(height: 30, child: Text("🔴 LIVE WD: Andi WD Rp 500.000 - Budi WD Rp 1.000.000", style: TextStyle(color: Colors.green))),
          // 8. Manajemen Bank
          _itemAkun("Manajemen Bank & Wallet - Wajib Daftar Sebelum WD"),
          // 9. Pengaturan
          ExpansionTile(title: Text("Pengaturan", style: TextStyle(color: Colors.white)), children: [
            ListTile(title: Text("Otomatis Langganan VIP", style: TextStyle(color: Colors.white70)), onTap: (){}),
            ListTile(title: Text("Ganti Bahasa", style: TextStyle(color: Colors.white70)), onTap: (){}),
            ListTile(title: Text("Keamanan Akun", style: TextStyle(color: Colors.white70)), onTap: (){}),
          ]),
          // 10. Hapus akun, 11. Log keluar
          _itemAkun("Hapus Akun", color: Colors.red[900]),
          SizedBox(height: 8),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]), onPressed: (){}, child: Text("Log Keluar", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Widget _dompetBox(){
    return Container(
      padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Dompet\nKoin: 5000", style: TextStyle(color: Colors.white)),
            Text("Rupiah\nRp 75.000", style: TextStyle(color: Colors.amber)),
          ]),
          SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _persenBox("25%"), _persenBox("50%"), _persenBox("75%"), _persenBox("100%"),
          ]),
          SizedBox(height: 12),
          Row(children: [
            ElevatedButton(onPressed: (){}, child: Text("Top Up QRIS")),
            SizedBox(width: 8),
            DropdownButton<String>(value: "50", items: ["50","100","150"].map((e)=> DropdownMenuItem(value: e, child: Text("$e Koin"))).toList(), onChanged: (v){}),
          ])
        ],
      ),
    );
  }

  Widget _persenBox(String p) => Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.amber[700], borderRadius: BorderRadius.circular(8)), child: Text(p));

  Widget _itemAkun(String t, {VoidCallback? onTap, bool isWD=false, Color? color}) => Container(margin: EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: color?? Colors.grey[900], borderRadius: BorderRadius.circular(12)), child: ListTile(title: Text(t, style: TextStyle(color: Colors.white, fontSize: 14)), trailing: Icon(isWD? Icons.account_balance_wallet : Icons.arrow_forward_ios, color: Colors.amber, size: 16), onTap: onTap));
}
