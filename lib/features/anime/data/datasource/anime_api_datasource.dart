import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/data/response/get_all_genre_response.dart';
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
}
