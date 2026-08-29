import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});
  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  bool canGoLive = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkVip();
  }

  Future<void> checkVip() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        setState(() { isLoading = false; });
        return;
      }
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final data = doc.data();
      // Legal check: paket 30rb = liveAccess true
      if (data!= null && (data['vipPackage'] == '30rb' || data['liveAccess'] == true)) {
        setState(() { canGoLive = true; });
      }
    } catch (e) {
      // ignore
    }
    setState(() { isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('DLOVID Live'), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: canGoLive
         ? GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
              itemBuilder: (c, i) => Card(
                color: Colors.grey[900],
                child: Center(child: Text('LIVE $i\nPaket 30rb Aktif', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))),
              ),
            )
          : Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.lock, color: Colors.amber, size: 64),
                const SizedBox(height: 16),
                const Text('Aktifkan Paket 30rb\nUntuk Buka Live!', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: () {}, child: const Text('Beli Paket 30rb - Legal')),
              ]),
            ),
      floatingActionButton: canGoLive
         ? FloatingActionButton.extended(
              backgroundColor: Colors.red,
              icon: const Icon(Icons.videocam),
              label: const Text('Go Live'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fitur Go Live Agora akan aktif setelah setup App ID - Legal')));
              },
            )
          : null,
    );
  }
}
