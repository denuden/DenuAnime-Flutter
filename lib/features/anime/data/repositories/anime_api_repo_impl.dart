import 'dart:io';

import 'package:denuanime/features/anime/data/datasource/anime_api_datasource.dart';
import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/repositories/anime_repo.dart';

class AnimeApiRepoImpl implements AnimeRepo {
  final AnimeApiDatasource api;

  AnimeApiRepoImpl(this.api);

  @override
  Future<List<GenreModel>> getAllGenres() async {
    final response = await api.getAllGenre();

    if (response.data?.isNotEmpty == true && response.data != null) {
      return response.data ?? [];
    } else {
      throw const HttpException("No genres found.");
    }
  }

  @override
  Future<List<AnimeDetailsModel>> searchAnime(
    SearchAnimeRequest request,
  ) async {
    final response = await api.searchAnime(request);

    if (response.data?.isNotEmpty == true && response.data != null) {
      return response.data ?? [];
    } else {
      throw const HttpException("No animes found.");
    }
  }
}
