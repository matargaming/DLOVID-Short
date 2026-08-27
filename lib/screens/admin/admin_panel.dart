import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        title: const Text("PANEL ADMIN ORIGINAL", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFD4AF37),
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, c) {
        bool tablet = c.maxWidth > 600;
        return GridView.count(
          crossAxisCount: tablet ? 3 : 2,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _card(context, "HOME", Icons.movie, Colors.blue, "Halaman utama video"),
            _card(context, "SARAN", Icons.video_library, Colors.purple, "Saran video"),
            _card(context, "BONUS\n11 Kotak", Icons.card_giftcard, Colors.amber, "Bonus pengguna"),
            _card(context, "AKUN\nDOMPET", Icons.account_balance_wallet, Colors.green, "Dompet koin"),
            _card(context, "DANA\nUSER", Icons.monetization_on, Colors.orange, "Dana pengguna"),
            _card(context, "MIDTRANS\nORIGINAL", Icons.payment, Colors.teal, "Payment gateway"),
            _card(context, "ADMOB\nORIGINAL", Icons.ad_units, Colors.cyan, "Iklan Admob"),
            _card(context, "FIREBASE\nTMDB SECRET", Icons.security, Colors.red, "Setting rahasia"),
          ],
        );
      }),
    );
  }

  Widget _card(BuildContext context, String t, IconData i, Color col, String desc) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$t - $desc - Segera Hadir"), backgroundColor: col),
        );
      },
      child: Card(
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: col.withOpacity(0.5), width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(i, size: 42, color: col),
            const SizedBox(height: 10),
            Text(t, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 4),
            Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 9)),
          ]),
        ),
      ),
    );
  }
}
