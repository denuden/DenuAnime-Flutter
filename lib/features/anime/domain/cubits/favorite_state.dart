import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/utils/core/async_value.dart';

class FavoriteState {
  final Async<void> addFavorite;
  final Async<List<AnimeDetailsModel>> favorites;
  final Set<int> ids;

  const FavoriteState({
    this.addFavorite = const AsyncIdle(),
    this.favorites = const AsyncIdle(),
    this.ids = const {},
  });

  FavoriteState copyWith({
    Async<void>? addFavorite,
    Async<List<AnimeDetailsModel>>? favorites,
    Set<int>? ids,
  }) {
    return FavoriteState(
      addFavorite: addFavorite ?? this.addFavorite,
      favorites: favorites ?? this.favorites,
      ids: ids ?? this.ids,
    );
  }
}
