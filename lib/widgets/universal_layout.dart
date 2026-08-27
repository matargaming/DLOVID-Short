import 'package:flutter/material.dart';

class UniversalLayout extends StatelessWidget {
  final Widget child;
  const UniversalLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF121212), Color(0xFF080808)],
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}
