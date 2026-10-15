import 'dart:async';

import 'package:denuanime/features/anime/data/request/favorite_anime_request.dart';
import 'package:denuanime/features/anime/data/request/toggle_watch_state_request.dart';
import 'package:denuanime/features/anime/domain/cubits/favorite_state.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/repositories/anime_repo.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final AnimeRepo animeRepo;
  StreamSubscription<List<AnimeDetailsModel>>? _favoritesSub;

  FavoriteCubit({required this.animeRepo}) : super(const FavoriteState());

  Future<void> toggleFavorites(FavoriteAnimeRequest request) async {
    emit(state.copyWith(addFavorite: const AsyncLoading()));

    //ads the saving ids to load only the one getting saved
    final id = request.mal_id;
    emit(state.copyWith(savingIds: {...state.savingIds, id}));
    try {
      await animeRepo.toggleFavorites(request);

      emit(state.copyWith(savingIds: {...state.savingIds}..remove(id)));

      if (isClosed) return;
      emit(state.copyWith(addFavorite: const AsyncIdle()));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(addFavorite: AsyncFailure(e.toString())));
      emit(state.copyWith(savingIds: {...state.savingIds}..remove(id)));
    }
  }

  Future<void> toggleWatchState(ToggleWatchStateRequest request) async {
    emit(state.copyWith(toggleWatchState: const AsyncLoading()));
    try {
      await animeRepo.toggleWatchState(request);

      if (isClosed) return;
      emit(state.copyWith(toggleWatchState: const AsyncIdle()));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(toggleWatchState: AsyncFailure(e.toString())));
    }
  }

  void start() {
    _favoritesSub?.cancel();
    emit(state.copyWith(favorites: const AsyncLoading()));

    _favoritesSub = animeRepo.getAnimeFavorites().listen(
      (list) {
        emit(
          state.copyWith(
            favorites: AsyncData(list),
            /*
           final ids = <int>{};
            for (final a in list) {
              if (a.mal_id != null) {
                ids.add(a.mal_id!);
              }
            }
          */
            ids: {
              for (final a in list)
                if (a.mal_id != null) a.mal_id!,
            },
          ),
        );
      },
      onError: (Object e) {
        debugPrint('favorites error: $e');
        emit(state.copyWith(favorites: AsyncFailure(e.toString())));
      },
    );
  }

  void stop() {
    _favoritesSub?.cancel();
    _favoritesSub = null;
    emit(const FavoriteState());
  }

  @override
  Future<void> close() {
    _favoritesSub?.cancel();
    return super.close();
  }
}
