android {
  defaultConfig {
    // INI YANG ARAHKAN KE SECRET KAMU - NO DUMMY
    buildConfigField("String","ADMIN_EMAIL","\"${System.getenv("ADMIN_EMAIL")}\"")
    buildConfigField("String","ADMIN_KEY_1","\"${System.getenv("ADMIN_KEY_1")}\"")
    buildConfigField("String","ADMIN_KEY_2","\"${System.getenv("ADMIN_KEY_2")}\"")
    buildConfigField("String","ADMIN_KEY_3","\"${System.getenv("ADMIN_KEY_3")}\"")
    buildConfigField("String","TMDB_API_KEY","\"${System.getenv("TMDB_API_KEY")}\"")
    buildConfigField("String","ADMOB_APP_ID","\"${System.getenv("ADMOB_APP_ID")}\"")
    buildConfigField("String","ADMOB_BANNER_ID","\"${System.getenv("ADMOB_BANNER_ID")}\"")
    buildConfigField("String","ADMOB_INTER_ID","\"${System.getenv("ADMOB_INTER_ID")}\"")
    buildConfigField("String","AGORA_APP_ID","\"${System.getenv("AGORA_APP_ID")}\"")
    buildConfigField("String","AGORA_APP_CERTIFICATE","\"${System.getenv("AGORA_APP_CERTIFICATE")}\"")
    buildConfigField("String","MIDTRANS_CLIENT_KEY","\"${System.getenv("MIDTRANS_CLIENT_KEY")}\"")
    buildConfigField("String","MIDTRANS_SERVER_KEY","\"${System.getenv("MIDTRANS_SERVER_KEY")}\"")
    buildConfigField("String","FIREBASE_PROJECT_ID","\"${System.getenv("FIREBASE_PROJECT_ID")}\"")
  }
}
