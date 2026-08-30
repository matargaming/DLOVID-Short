package com.dlovid.dlovids.data.tmdb

import retrofit2.http.GET
import retrofit2.http.Query

data class TmdbMovie(
    val id: Int,
    val title: String? = null,
    val name: String? = null,
    val poster_path: String?,
    val overview: String? = null
) {
    fun displayTitle(): String = title ?: name ?: ""
    fun isValid(): Boolean = displayTitle().isNotEmpty() && !poster_path.isNullOrEmpty()
}

data class TmdbResponse(
    val results: List<TmdbMovie>
)

interface TmdbApiService {
    @GET("trending/all/week")
    suspend fun getTrendingWeekly(
        @Query("api_key") apiKey: String,
        @Query("language") lang: String = "id-ID"
    ): TmdbResponse
}
