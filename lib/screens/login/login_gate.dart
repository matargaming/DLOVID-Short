import 'package:flutter/material.dart';
import '../../widgets/universal_layout.dart';
import '../admin/admin_panel.dart';

class LoginGate extends StatefulWidget {
  const LoginGate({super.key});
  @override
  State<LoginGate> createState() => _LoginGateState();
}

class _LoginGateState extends State<LoginGate> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  final _referral = TextEditingController();
  final _hp = TextEditingController();
  bool _obs1=true, _obs2=true;
  int _step=1;

  final String adminEmail="matargaming17@gmail.com";
  final String s1="Bosmatar123.321";
  final String s2="Bosmatar456.654";
  final String s3="BOSMATAR21100169830188";

  void _login() {
    if(_email.text.trim()!=adminEmail){ snack("RANGKA INI: Hanya ADMIN bisa login, user biasa BELUM AKTIF"); return; }
    if(_referral.text.trim().isEmpty){ snack("Daftar tanpa Referral DITOLAK APK!"); return; }
    if(_pass.text!=s1){ snack("Email/Sandi tidak sesuai - DITOLAK"); return; }
    setState(()=>_step=2);
  }
  void _s2(){ if(_pass.text==s2){ setState(()=>_step=3); _pass.clear(); } else snack("Sandi 2 Salah"); }
  void _s3(){ if(_pass.text==s3){ Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>const AdminPanel())); } else snack("Sandi 3 Salah"); }
  void snack(String m){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m), backgroundColor: Colors.red)); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UniversalLayout(
        mobile: _form(),
        tablet: Row(children: [
          Expanded(child: Container(color: Color(0xFF111111), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            DGoldLogo(size: 150), SizedBox(height: 20),
            Text("DLOVID-Short", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 32, fontWeight: FontWeight.bold)),
            Text("UNIVERSAL ORIGINAL", style: TextStyle(color: Colors.white54)),
          ])))),
          Expanded(child: _form()),
        ]),
      ),
    );
  }

  Widget _form(){
    return SingleChildScrollView(padding: EdgeInsets.all(24), child: Column(children: [
      SizedBox(height: 40), DGoldLogo(), SizedBox(height: 16),
      Text(_step==1?"LOGIN GATE ORIGINAL":_step==2?"SANDI 2":"SANDI 3 FINAL", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
      SizedBox(height: 24),
      if(_step==1)...[
        field(_email,"Email / No HP", Icons.email),
        field(_hp,"No HP OTP", Icons.phone),
        field(_pass,"Sandi + intip", Icons.lock, isPass:true, obs:_obs1, toggle:()=>setState(()=>_obs1=!_obs1)),
        field(_confirm,"Confirm Sandi + intip", Icons.lock_outline, isPass:true, obs:_obs2, toggle:()=>setState(()=>_obs2=!_obs2)),
        field(_referral,"Kode Referral WAJIB", Icons.card_giftcard),
        SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37), padding: EdgeInsets.all(16)), onPressed: _login, child: Text("LOGIN / DAFTAR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
      ] else ...[
        field(_pass, _step==2?"Masukkan Sandi 2":"Masukkan Sandi 3", Icons.security, isPass:true, obs:true, toggle:(){}),
        SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37)), onPressed: _step==2?_s2:_s3, child: Text(_step==2?"LANJUT SANDI 3":"MASUK PANEL ADMIN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
      ]
    ]));
  }
  Widget field(TextEditingController c, String l, IconData i, {bool isPass=false, bool obs=false, VoidCallback? toggle}){
    return Padding(padding: EdgeInsets.only(bottom: 12), child: TextField(controller: c, obscureText: isPass?obs:false, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l, prefixIcon: Icon(i, color: Color(0xFFD4AF37)), suffixIcon: isPass?IconButton(icon: Icon(obs?Icons.visibility_off:Icons.visibility), onPressed: toggle):null, filled: true, fillColor: Color(0xFF1E1E1E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))));
  }
}
