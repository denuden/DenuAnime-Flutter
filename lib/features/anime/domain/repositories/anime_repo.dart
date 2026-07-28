import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';

abstract class AnimeRepo {
  Future<List<AnimeDetailsModel>> searchAnime(SearchAnimeRequest request);
  Future<List<GenreModel>> getAllGenres();
}
