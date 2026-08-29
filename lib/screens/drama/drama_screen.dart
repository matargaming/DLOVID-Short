import 'package:flutter/material.dart';
class DramaScreen extends StatelessWidget {
  const DramaScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('DLOVID Drama'), actions: [
        IconButton(icon: const Icon(Icons.workspace_premium, color: Colors.amber), onPressed: ()=> ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('VIP 1 Bulan 30.000 QRIS di Menu Akun')))),
        IconButton(icon: const Icon(Icons.search), onPressed: (){}),
      ]),
      body: Column(children: [
        SizedBox(height: 180, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 10, itemBuilder: (c,i)=> Container(margin: const EdgeInsets.all(8), width: 120, decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(12)), child: Center(child: Text('TMDB ${i+1}'))))),
        Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7), itemCount: 20, itemBuilder: (c,i)=> Card(margin: const EdgeInsets.all(8), color: Colors.grey[900], child: Column(children: [Expanded(child: Container(color: Colors.grey[800], child: Center(child: Text('Film ${i+1}')))), Padding(padding: const EdgeInsets.all(8), child: Text('Judul Drama ${i+1}'))])))),
      ]),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: const Text('Next Episode'), icon: const Icon(Icons.skip_next)),
    );
  }
}
