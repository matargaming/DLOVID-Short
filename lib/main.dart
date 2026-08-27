import 'package:flutter/material.dart';
import 'screens/saran_screen.dart';
import 'screens/bonus_screen.dart';
import 'screens/akun_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login/login_gate.dart';

void main() => runApp(DlovidApp());

class DlovidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginGate(),
    );
  }
}

class MainNav extends StatefulWidget {
  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _index = 0;
  final _pages = [SaranScreen(), HomeScreen(), BonusScreen(), AkunScreen()];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        currentIndex: _index,
        onTap: (i)=> setState(()=> _index=i),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.recommend), label: "Saran"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Bonus"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
      ),
    );
  }
}
