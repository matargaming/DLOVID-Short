import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class MidtransService {
  static const serverKey = String.fromEnvironment('MIDTRANS_SERVER_KEY');
  
  static Future<void> showVipQRIS({required Function onSuccess}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final orderId = 'VIP-${user.uid}-${DateTime.now().millisecondsSinceEpoch}';
    final body = {
      "payment_type": "qris",
      "transaction_details": {"order_id": orderId, "gross_amount": 30000},
      "item_details": [{"id": "vip1bulan", "price": 30000, "quantity": 1, "name": "VIP DLOVID 1 Bulan"}],
    };
    final res = await http.post(
      Uri.parse('https://api.sandbox.midtrans.com/v2/charge'),
      headers: {'Content-Type': 'application/json','Authorization': 'Basic ${base64Encode(utf8.encode('$serverKey:'))}'},
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'vipUntil': DateTime.now().add(Duration(days: 30)).toIso8601String(),
        'isVip': true,
      }, SetOptions(merge: true));
      onSuccess();
    }
  }

  static Future<bool> checkVipActive() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (!doc.exists) return false;
    final vipUntilStr = doc.data()?['vipUntil'];
    if (vipUntilStr == null) return false;
    return DateTime.now().isBefore(DateTime.parse(vipUntilStr));
  }
}
