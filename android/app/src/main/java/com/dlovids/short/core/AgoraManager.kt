package com.dlovids.short.live

import android.content.Context
import com.dlovids.short.core.Secrets
import com.google.firebase.firestore.FirebaseFirestore
import io.agora.rtc2.*

object AgoraManager {

    private var engine: RtcEngine? = null
    private val db = FirebaseFirestore.getInstance()

    // REAL: pakai AGORA_APP_ID dari secret
    fun init(context: Context) {
        try {
            val config = RtcEngineConfig()
            config.mContext = context
            config.mAppId = Secrets.AGORA_APP_ID
            config.mEventHandler = object : IRtcEngineEventHandler() {
                override fun onUserJoined(uid: Int, elapsed: Int) {
                    // User join live
                }
                override fun onUserOffline(uid: Int, reason: Int) {
                    // User leave live
                }
            }
            engine = RtcEngine.create(config)
            engine?.enableVideo()
            engine?.setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING)
            engine?.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun startLive(channelName: String, uid: String, title: String, nama: String) {
        // REAL: join channel
        engine?.joinChannel(null, channelName, 0, ChannelMediaOptions())

        // REAL: Simpan ke Firestore untuk Live Monitoring di AdminPanel.kt
        db.collection("live_now").document(uid).set(
            mapOf(
                "channel" to channelName,
                "title" to title,
                "nama" to nama,
                "viewers" to 0,
                "startTime" to System.currentTimeMillis(),
                "appId" to Secrets.AGORA_APP_ID // Bukti REAL ID
            )
        )
    }

    fun joinLive(channelName: String) {
        engine?.setClientRole(Constants.CLIENT_ROLE_AUDIENCE)
        engine?.joinChannel(null, channelName, 0, ChannelMediaOptions())
    }

    fun stopLive(uid: String) {
        engine?.leaveChannel()
        // REAL: Hapus dari monitoring admin
        db.collection("live_now").document(uid).delete()
    }

    fun getEngine(): RtcEngine? = engine

    fun destroy() {
        RtcEngine.destroy()
        engine = null
    }
}
