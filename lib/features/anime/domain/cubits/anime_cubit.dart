import 'dart:io';

import 'package:denuanime/features/anime/data/request/get_anime_details_full_request.dart';
import 'package:denuanime/features/anime/data/request/get_recommendations_request.dart';
import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/repositories/anime_repo.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_state.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeCubit extends Cubit<AnimeState> {
  final AnimeRepo animeRepo;

  //holder
  SearchAnimeRequest _currentRequest = const SearchAnimeRequest();

  AnimeCubit({required this.animeRepo}) : super(const AnimeState());

  // * ================== search anime
  Future<void> searchAnime(SearchAnimeRequest request) async {
    _currentRequest = request.copyWith(page: () => 1);
    emit(
      state.copyWith(
        animes: const AsyncLoading(),
        hasNextPage: false,
        isLoadingMore: false,
      ),
    );
    try {
      final result = await animeRepo.searchAnime(_currentRequest);

      if (isClosed) return;
      emit(
        state.copyWith(
          animes: AsyncData(result.items),
          hasNextPage: result.hasNextPage,
        ),
      );
    } on HttpException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(animes: AsyncFailure(e.message.toString())));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(animes: AsyncFailure(e.toString())));
    }
  }

  Future<void> loadMoreAnime() async {
    final current = state.animes;
    if (current is! AsyncData<List<AnimeDetailsModel>>) return;
    if (state.isLoadingMore || !state.hasNextPage) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = (_currentRequest.page ?? 1) + 1;
    final nextRequest = _currentRequest.copyWith(page: () => nextPage);

    try {
      final result = await animeRepo.searchAnime(nextRequest);
      if (isClosed) return;
      _currentRequest = nextRequest;
      emit(
        state.copyWith(
          animes: AsyncData([...current.value, ...result.items]),
          isLoadingMore: false,
          hasNextPage: result.hasNextPage,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  // * ================== end search anime

  Future<void> getAllGenres() async {
    emit(state.copyWith(genres: const AsyncLoading()));

    try {
      final genres = await animeRepo.getAllGenres();
      if (isClosed) return;
      emit(state.copyWith(genres: AsyncData(genres)));
    } on HttpException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(genres: AsyncFailure(e.message)));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(genres: AsyncFailure(e.toString())));
    }
  }

  Future<void> getAllRecommendations(GetRecommendationsRequest request) async {
    emit(state.copyWith(recommendations: const AsyncLoading()));

    try {
      final result = await animeRepo.getRecommendations(request);
      if (isClosed) return;
      emit(state.copyWith(recommendations: AsyncData(result)));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(recommendations: AsyncFailure(e.toString())));
    }
  }

  Future<void> getAnimeDetailsFull(GetAnimeDetailsFullRequest request) async {
    emit(state.copyWith(animeDetails: const AsyncLoading()));

    try {
      final result = await animeRepo.getAnimeDetailsFull(request);
      if (isClosed) return;
      emit(state.copyWith(animeDetails: AsyncData(result)));
    } on HttpException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(animeDetails: AsyncFailure(e.message.toString())));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(animeDetails: AsyncFailure(e.toString())));
    }
  }

  Future<void> getAnimeCharacters(GetAnimeDetailsFullRequest request) async {
    emit(state.copyWith(characters: const AsyncLoading()));

    try {
      final result = await animeRepo.getAnimeCharacters(request);
      if (isClosed) return;
      emit(state.copyWith(characters: AsyncData(result)));
    } on HttpException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(characters: AsyncFailure(e.message.toString())));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(characters: AsyncFailure(e.toString())));
    }
  }

  Future<void> getLatestSchedules() =>
      _loadRecents(() => animeRepo.getLatestSchedules());

  Future<void> getSeasonalAnimeCurrent() =>
      _loadRecents(() => animeRepo.getSeasonalAnimeCurrent());

  Future<void> getSeasonalAnimeUpcoming() =>
      _loadRecents(() => animeRepo.getSeasonalAnimeUpcoming());

  Future<void> _loadRecents(
    Future<List<AnimeDetailsModel>> Function() fetch,
  ) async {
    if (state.recents is AsyncLoading) return;

    emit(state.copyWith(recents: const AsyncLoading()));

    try {
      final result = await fetch();
      if (isClosed) return;
      emit(state.copyWith(recents: AsyncData(result)));
    } on HttpException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(recents: AsyncFailure(e.message.toString())));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(recents: AsyncFailure(e.toString())));
    }
  }

  //? ====================== local calls
  String toggleGenre(int malId, bool selected) {
    final current = state.genres;
    if (current is! AsyncData<List<GenreModel>>) return '';

    final updatedGenres = current.value.map((genre) {
      if (genre.mal_id == malId) {
        return genre.copyWith(is_selected: selected);
      }
      return genre;
    }).toList();

    updatedGenres.sort((a, b) {
      // Selected first
      if (a.is_selected != b.is_selected) {
        return a.is_selected ? -1 : 1;
      }

      // Alphabetical within each group
      return (a.name ?? '').compareTo(b.name ?? '');
    });

    emit(state.copyWith(genres: AsyncData(updatedGenres)));

    return updatedGenres
        .where((g) => g.is_selected)
        .map((g) => g.mal_id.toString())
        .join(',');
  }
}
