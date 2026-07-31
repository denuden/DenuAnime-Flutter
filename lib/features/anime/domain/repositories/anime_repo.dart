import 'package:denuanime/features/anime/data/request/get_anime_details_full_request.dart';
import 'package:denuanime/features/anime/data/request/get_recommendations_request.dart';
import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';

abstract class AnimeRepo {
  Future<List<AnimeDetailsModel>> searchAnime(SearchAnimeRequest request);
  Future<List<GenreModel>> getAllGenres();
  Future<List<RecommendationModel>> getRecommendations(
    GetRecommendationsRequest request,
  );
  Future<AnimeDetailsModel> getAnimeDetailsFull(
    GetAnimeDetailsFullRequest request,
  );
}
