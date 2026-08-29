package com.dlovids.short.data

import com.dlovids.short.core.Secrets
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.Query

// Model REAL
data class TmdbResponse(val results: List<TmdbMovie>)
data class TmdbMovie(
    val id: Int,
    val title: String,
    val overview: String,
    val poster_path: String,
    val vote_average: Double
)

interface TmdbApi {
    @GET("movie/popular")
    suspend fun getPopular(@Query("api_key") apiKey: String = Secrets.TMDB_API_KEY, @Query("language") lang: String = "id-ID"): TmdbResponse

    @GET("search/movie")
    suspend fun searchMovie(@Query("api_key") apiKey: String = Secrets.TMDB_API_KEY, @Query("query") q: String): TmdbResponse

    @GET("movie/top_rated")
    suspend fun getTopRated(@Query("api_key") apiKey: String = Secrets.TMDB_API_KEY): TmdbResponse
}

object TmdbClient {
    val api: TmdbApi by lazy {
        Retrofit.Builder()
            .baseUrl(Secrets.TMDB_BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(TmdbApi::class.java)
    }

    fun getImageUrl(path: String): String {
        return Secrets.TMDB_IMAGE_URL + path
    }
}
