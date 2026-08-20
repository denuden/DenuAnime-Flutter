import 'dart:io';

import 'package:denuanime/features/anime/data/datasource/anime_api_datasource.dart';
import 'package:denuanime/features/anime/data/request/get_anime_details_full_request.dart';
import 'package:denuanime/features/anime/data/request/get_recommendations_request.dart';
import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/entities/anime_characters_model.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';
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

  @override
  Future<List<RecommendationModel>> getRecommendations(
    GetRecommendationsRequest request,
  ) async {
    final response = await api.getRecommendations(request);

    if (response.data?.isNotEmpty == true && response.data != null) {
      return response.data ?? [];
    } else {
      throw const HttpException("No recommendataions found.");
    }
  }

  @override
  Future<AnimeDetailsModel> getAnimeDetailsFull(
    GetAnimeDetailsFullRequest request,
  ) async {
    final response = await api.getAnimeDetailsFull(request);

    if (response.data != null) {
      return response.data ?? const AnimeDetailsModel();
    } else {
      throw HttpException("Cannot find anime with id of ${request.id}");
    }
  }

  @override
  Future<List<AnimeCharactersModel>> getAnimeCharacters(
    GetAnimeDetailsFullRequest request,
  ) async {
    final response = await api.getAnimeCharacters(request);

    if (response.data != null) {
      return response.data ?? [];
    } else {
      throw HttpException("Cannot find anime with id of ${request.id}");
    }
  }

  @override
  Future<List<AnimeDetailsModel>> getLatestSchedules() async {
    final response = await api.getLatestSchedules();

    if (response.data?.isNotEmpty == true && response.data != null) {
      return response.data ?? [];
    } else {
      throw const HttpException("Cannot find latest schedules of anime");
    }
  }

  @override
  Future<List<AnimeDetailsModel>> getSeasonalAnimeCurrent() async {
    final response = await api.getSeasonalAnimeCurrent();

    if (response.data?.isNotEmpty == true && response.data != null) {
      return response.data ?? [];
    } else {
      throw const HttpException("Cannot find latest schedules of anime");
    }
  }

  @override
  Future<List<AnimeDetailsModel>> getSeasonalAnimeUpcoming() async {
    final response = await api.getSeasonalAnimeUpcoming();

    if (response.data?.isNotEmpty == true && response.data != null) {
      return response.data ?? [];
    } else {
      throw const HttpException("Cannot find latest schedules of anime");
    }
  }
}
