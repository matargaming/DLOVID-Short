import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../services/live_service.dart';
import '../services/midtrans_service.dart';

class PlusScreen extends StatefulWidget {
  const PlusScreen({super.key});
  @override
  State<PlusScreen> createState() => _PlusScreenState();
}

class _PlusScreenState extends State<PlusScreen> {
  bool _isVip = false;
  bool _isLive = false;
  RtcEngine? _engine;

  @override
  void initState() { super.initState(); _checkVip(); }
  Future<void> _checkVip() async { bool vip = await MidtransService.checkVipActive(); setState(() => _isVip = vip); }

  Future<void> _onGoLive() async {
    if (!_isVip) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
          backgroundColor: Colors.black,
          title: Text('VIP Dulu Bos 30K / Bulan', style: TextStyle(color: Colors.white)),
          content: Text('Live cuma buat VIP Bos, QRIS langsung aktif 1 bulan + Gift 50% + Bebas Iklan!', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c), child: Text('Nanti')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                Navigator.pop(c);
                MidtransService.showVipQRIS(onSuccess: () {
                  setState(() => _isVip = true);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('VIP AKTIF 1 BULAN BOS!')));
                });
              },
              child: Text('BAYAR QRIS 30K'),
            )
          ],
        ),
      );
      return;
    }
    _engine = await LiveService.initBroadcaster();
    await LiveService.joinChannel('dlovid_live_${DateTime.now().millisecondsSinceEpoch}');
    setState(() => _isLive = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLive) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          AgoraVideoView(controller: VideoViewController(rtcEngine: _engine!, canvas: VideoCanvas(uid: 0))),
          Positioned(top: 40, left: 16, child: ElevatedButton(onPressed: () { LiveService.leave(); setState(() => _isLive = false); }, child: Text('End Live'))),
        ]),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('DLOVID Live'), backgroundColor: Colors.black),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.live_tv, size: 100, color: _isVip ? Colors.red : Colors.grey),
          SizedBox(height: 20),
          Text(_isVip ? 'VIP Aktif - Siap Live Bos!' : 'Butuh VIP untuk Live', style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
            onPressed: _onGoLive,
            child: Text(_isVip ? 'GO LIVE SEKARANG' : 'AKTIFKAN VIP 30K (QRIS)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}
