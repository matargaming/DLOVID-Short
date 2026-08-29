package com.dlovids.short.ads

import android.content.Context
import android.util.Log
import com.dlovids.short.core.Secrets
import com.google.android.gms.ads.*
import com.google.android.gms.ads.interstitial.InterstitialAd
import com.google.android.gms.ads.interstitial.InterstitialAdLoadCallback
import com.google.firebase.firestore.FirebaseFirestore

object AdMobManager {

    private var interstitial: InterstitialAd? = null
    private var adCount = 0
    private val db = FirebaseFirestore.getInstance()

    fun init(context: Context) {
        // REAL APP ID dari Secret ADMOB_APP_ID
        MobileAds.initialize(context) {}
        loadInterstitial(context)
    }

    fun loadBanner(context: Context): AdView {
        return AdView(context).apply {
            // REAL BANNER ID dari Secret
            adUnitId = Secrets.ADMOB_BANNER_ID
            setAdSize(AdSize.BANNER)
            loadAd(AdRequest.Builder().build())
        }
    }

    fun loadInterstitial(context: Context) {
        // REAL INTER ID dari Secret
        InterstitialAd.load(context, Secrets.ADMOB_INTER_ID, AdRequest.Builder().build(),
            object : InterstitialAdLoadCallback() {
                override fun onAdLoaded(ad: InterstitialAd) {
                    interstitial = ad
                    Log.d("ADMOB_REAL", "Inter loaded REAL ID: ${Secrets.ADMOB_INTER_ID}")
                }
                override fun onAdFailedToLoad(err: LoadAdError) {
                    interstitial = null
                }
            })
    }

    fun showInterstitial(context: android.app.Activity, userId: String, onFinish: () -> Unit) {
        interstitial?.let { ad ->
            ad.fullScreenContentCallback = object : FullScreenContentCallback() {
                override fun onAdDismissedFullScreenContent() {
                    adCount++
                    // REAL: Simpan ke Firestore untuk Kotak Live Iklan Ditonton di AdminPanel
                    db.collection("ad_logs").add(
                        mapOf(
                            "userId" to userId,
                            "count" to 1,
                            "date" to System.currentTimeMillis().toString(),
                            "adUnit" to Secrets.ADMOB_INTER_ID
                        )
                    )
                    loadInterstitial(context)
                    onFinish()
                }
                override fun onAdFailedToShowFullScreenContent(p0: AdError) {
                    onFinish()
                }
            }
            ad.show(context)
        } ?: onFinish()
    }

    fun shouldShowAd(): Boolean {
        // Aturan: Tiap 3 drama = 1 iklan
        return adCount % 3 == 0
    }
}
