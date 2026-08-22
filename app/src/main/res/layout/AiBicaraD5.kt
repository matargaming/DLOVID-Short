package com.dlovid.short

import android.animation.ObjectAnimator
import android.speech.tts.TextToSpeech
import android.widget.TextView
import java.util.*

class AiBicaraD5(private val mataKiri: TextView, private val mataKanan: TextView, private val txtLirik: TextView) : TextToSpeech.OnInitListener {

    private var tts: TextToSpeech? = null
    private var isReady = false

    init {
        tts = TextToSpeech(mataKiri.context, this)
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts?.language = Locale("id", "ID")
            isReady = true
        }
    }

    fun bicara(teks: String, lirikSync: String = "") {
        if (!isReady) return

        // 1. Update Lirik
        txtLirik.text = if (lirikSync.isNotEmpty()) lirikSync else teks

        // 2. Animasi Mata Kedip + Lirik
        kedipMata()
        
        // 3. TTS Bicara
        tts?.speak(teks, TextToSpeech.QUEUE_FLUSH, null, "AI_D5")

        // 4. Animasi Mata Gerak Kiri Kanan
        gerakMata()
    }

    private fun kedipMata() {
        val animKiri = ObjectAnimator.ofFloat(mataKiri, "alpha", 1f, 0f, 1f)
        animKiri.duration = 200
        animKiri.start()

        val animKanan = ObjectAnimator.ofFloat(mataKanan, "alpha", 1f, 0f, 1f)
        animKanan.duration = 200
        animKanan.startDelay = 50
        animKanan.start()
    }

    private fun gerakMata() {
        mataKiri.animate().translationXBy(10f).setDuration(150).withEndAction {
            mataKiri.animate().translationXBy(-10f).setDuration(150).start()
        }.start()

        mataKanan.animate().translationXBy(10f).setDuration(150).withEndAction {
            mataKanan.animate().translationXBy(-10f).setDuration(150).start()
        }.start()
    }

    fun bicaraBonusD4(totalTeman: Int, poin: Int) {
        val teks = when {
            totalTeman == 0 -> "Hai bos! Ajak teman pertama yuk, biar poin nambah!"
            totalTeman < 5 -> "Mantap! Sudah $totalTeman teman. Lanjut ajak lagi biar robot makin semangat!"
            else -> "WOW! Kamu hebat! $totalTeman teman, poin $poin! Robot AI bangga!"
        }
        bicara(teks, "♪ $teks ♪")
    }

    fun destroy() {
        tts?.stop()
        tts?.shutdown()
    }
}
