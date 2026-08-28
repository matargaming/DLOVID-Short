import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Text("USER HOME - PENDING MENUNGGU ADMIN", style: TextStyle(color: Colors.white))),
    );
  }
}
