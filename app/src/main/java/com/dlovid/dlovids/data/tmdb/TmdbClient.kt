package com.dlovid.dlovids.data

import retrofit2.http.GET
import retrofit2.http.Query

data class TmdbMovie(
    val id: Int,
    val title: String = "",
    val name: String = "",
    val overview: String = "",
    val poster_path: String? = null
)

data class TmdbResponse(
    val results: List<TmdbMovie>
)

interface TmdbApi {
    @GET("trending/all/day")
    suspend fun getTrending(@Query("api_key") apiKey: String): TmdbResponse

    @GET("movie/popular")
    suspend fun getPopular(@Query("api_key") apiKey: String): TmdbResponse
}
