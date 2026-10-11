import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/utils/core/async_value.dart';

class FavoriteState {
  final Async<void> addFavorite;
  final Async<List<AnimeDetailsModel>> favorites;
  final Set<int> ids;
  final Set<int> savingIds;

  const FavoriteState({
    this.addFavorite = const AsyncIdle(),
    this.favorites = const AsyncIdle(),
    this.ids = const {},
    this.savingIds = const {},
  });

  FavoriteState copyWith({
    Async<void>? addFavorite,
    Async<List<AnimeDetailsModel>>? favorites,
    Set<int>? ids,
    Set<int>? savingIds,
  }) {
    return FavoriteState(
      addFavorite: addFavorite ?? this.addFavorite,
      favorites: favorites ?? this.favorites,
      ids: ids ?? this.ids,
      savingIds: savingIds ?? this.savingIds,
    );
  }
}
