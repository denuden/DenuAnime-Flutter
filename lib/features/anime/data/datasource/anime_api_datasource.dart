import 'package:denuanime/features/anime/data/request/get_anime_details_full_request.dart';
import 'package:denuanime/features/anime/data/request/get_recommendations_request.dart';
import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/data/response/get_all_genre_response.dart';
import 'package:denuanime/features/anime/data/response/get_anime_characters_response.dart';
import 'package:denuanime/features/anime/data/response/get_anime_details_full_response.dart';
import 'package:denuanime/features/anime/data/response/get_latest_schedules_response.dart';
import 'package:denuanime/features/anime/data/response/get_recommendations_response.dart';
import 'package:denuanime/features/anime/data/response/search_anime_response.dart';
import 'package:dio/dio.dart';

class AnimeApiDatasource {
  final Dio dio;

  AnimeApiDatasource(this.dio);

  Future<GetAllGenreResponse> getAllGenre() async {
    final response = await dio.get<Map<String, dynamic>>("/genres/anime");

    return GetAllGenreResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<SearchAnimeResponse> searchAnime(SearchAnimeRequest request) async {
    final response = await dio.get<Map<String, dynamic>>(
      "/anime",
      queryParameters: request.toQueryParameters(),
    );

    return SearchAnimeResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<GetRecommendationsResponse> getRecommendations(
    GetRecommendationsRequest request,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      "/recommendations/anime",
      queryParameters: request.toQueryParameters(),
    );

    return GetRecommendationsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<GetAnimeDetailsFullResponse> getAnimeDetailsFull(
    GetAnimeDetailsFullRequest request,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      "/anime/${request.id}/full",
    );

    return GetAnimeDetailsFullResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<GetAnimeCharactersResponse> getAnimeCharacters(
    GetAnimeDetailsFullRequest request,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      "/anime/${request.id}/characters",
    );

    return GetAnimeCharactersResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<GetLatestSchedulesResponse> getLatestSchedules() async {
    final response = await dio.get<Map<String, dynamic>>("/schedules");

    return GetLatestSchedulesResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
