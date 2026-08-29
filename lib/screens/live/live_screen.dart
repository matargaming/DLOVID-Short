import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class LiveScreen extends StatefulWidget {
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  bool canGoLive = false;

  @override
  void initState() {
    super.initState();
    checkVip();
  }

  void checkVip() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.data()?['vipPackage'] == '30rb' || doc.data()?['liveAccess'] == true) {
      setState(() => canGoLive = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DLOVID Live'), backgroundColor: Colors.black),
      body: canGoLive 
        ? GridView.builder(
            itemCount: 10, // data live dari firestore
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (c,i) => Card(child: Center(child: Text('Live $i'))),
          )
        : Center(child: Text('Aktifkan Paket 30rb untuk buka Live!')),
      floatingActionButton: canGoLive ? FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.videocam),
        onPressed: () {/* start Agora live */},
      ) : null,
    );
  }
}
