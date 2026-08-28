onPressed: () async {
  try {
    if (_isDaftar) {
      await _auth.register(
        emailOrHp: _emailCtrl.text,
        sandi: _passCtrl.text,
        confirm: _confirmCtrl.text,
        referralCode: _referralCtrl.text,
        otp: _otpCtrl.text
      );
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Daftar sukses, silakan login')));
        setState(()=> _isDaftar = false);
      }
    } else {
      final res = await _auth.login(_emailCtrl.text, _passCtrl.text);
      if (res == null) {
        setState(()=> _isAdminStage2 = true);
        return;
      }
      // INI KUNCI KE MENU AKUN:
      if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainNav()));
    }
  } catch (e) {
    if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
},
