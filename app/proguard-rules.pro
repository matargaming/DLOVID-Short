# Anti Hecker - Jaga Kode DLOVID
-keep class com.dlovids.app.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.midtrans.** { *; }

# Anti Decompile
-obfuscationdictionary proguard_dict.txt
-classobfuscationdictionary proguard_dict.txt
-packageobfuscationdictionary proguard_dict.txt

# 1 HP 1 Akun - Jaga Device ID
-keep class android.provider.Settings$Secure { *; }
-keep class android.os.Build { *; }

# Admob biar gak error pas di-obfuscate
-keep class com.google.android.gms.ads.** { *; }
