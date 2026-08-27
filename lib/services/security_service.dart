import 'package:device_info_plus/device_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecurityService {
  // Cek 1 device 1 akun
  static Future<bool> checkOneDevice(String uid) async {
    final deviceId = (await DeviceInfoPlugin().androidInfo).id;
    final doc = await FirebaseFirestore.instance.collection('devices').doc(deviceId).get();
    if (doc.exists && doc.data()!['uid']!= uid) {
      // Blokir - lebih dari 1 akun
      await FirebaseFirestore.instance.collection('blocked').doc(deviceId).set({'reason': 'Multi akun'});
      return false;
    }
    await FirebaseFirestore.instance.collection('devices').doc(deviceId).set({'uid': uid});
    return true;
  }

  // Point 15: Anti hecker pantau
  static bool isSafe() {
    // Cek root, emulator, debug
    // Tambah: flutter_jailbreak_detection, obfuscate dengan --obfuscate --split-debug-info
    return true;
  }
}
