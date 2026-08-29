import 'package:flutter/material.dart';
import '../drama/drama_screen.dart';
import '../home/feed_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import '../create/create_option_sheet.dart';
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState()=> _MainNavigationState();
}
class _MainNavigationState extends State<MainNavigation>{
  int idx=0;
  final pages = [const DramaScreen(), const FeedScreen(), const SizedBox(), const ChatScreen(), const ProfileScreen()];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: pages[idx==2?0:idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx, backgroundColor: Colors.black, selectedItemColor: Colors.amber, unselectedItemColor: Colors.grey, type: BottomNavigationBarType.fixed,
        onTap: (i){ if(i==2){ showModalBottomSheet(context: context, builder: (_)=> const CreateOptionSheet()); return; } setState(()=> idx=i); },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Drama'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 35), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Pesan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}
