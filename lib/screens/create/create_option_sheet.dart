import 'package:flutter/material.dart';

class CreateOptionSheet extends StatelessWidget {
  const CreateOptionSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.live_tv, color: Colors.red, size: 30),
            title: const Text('LIVE - Butuh VIP'),
            subtitle: const Text('Rp 30.000/bulan QRIS'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Beli VIP 1 Bulan Rp 30.000 - QRIS di Menu Akun')));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_call, color: Colors.amber, size: 30),
            title: const Text('Upload Video'),
            subtitle: const Text('Masuk Galeri'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
