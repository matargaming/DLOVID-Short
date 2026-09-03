package com.dlovid.dlovids

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.ui.PlayerView

class VideoAdapter(private val urls: List<String>) : RecyclerView.Adapter<VideoAdapter.VH>() {

    class VH(view: View) : RecyclerView.ViewHolder(view) {
        val playerView: PlayerView = view.findViewById(R.id.playerView)
        var player: ExoPlayer? = null
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VH {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_video, parent, false)
        return VH(view)
    }

    override fun onBindViewHolder(holder: VH, position: Int) {
        holder.player?.release()
        val player = ExoPlayer.Builder(holder.playerView.context).build()
        holder.playerView.player = player
        holder.player = player

        val mediaItem = MediaItem.fromUri(urls[position])
        player.setMediaItem(mediaItem)
        player.prepare()
        player.playWhenReady = true
        player.repeatMode = ExoPlayer.REPEAT_MODE_ONE
    }

    override fun onViewRecycled(holder: VH) {
        holder.player?.release()
        holder.player = null
        super.onViewRecycled(holder)
    }

    override fun getItemCount() = urls.size
}
