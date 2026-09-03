package com.dlovid.dlovids
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.ui.PlayerView

class VideoAdapter(private val urls: List<String>) : RecyclerView.Adapter<VideoAdapter.VH>() {
    class VH(val playerView: PlayerView) : RecyclerView.ViewHolder(playerView)
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VH {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_video, parent, false) as PlayerView
        return VH(view)
    }
    override fun onBindViewHolder(holder: VH, position: Int) {
        val player = ExoPlayer.Builder(holder.playerView.context).build()
        holder.playerView.player = player
        player.setMediaItem(MediaItem.fromUri(urls[position]))
        player.prepare()
        player.playWhenReady = true
        player.repeatMode = ExoPlayer.REPEAT_MODE_ONE
    }
    override fun getItemCount() = urls.size
}
