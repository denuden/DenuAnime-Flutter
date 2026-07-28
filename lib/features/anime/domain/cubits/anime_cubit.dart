import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/repositories/anime_repo.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeCubit extends Cubit<AnimeState> {
  final AnimeRepo animeRepo;

  AnimeCubit({required this.animeRepo}) : super(AnimeInitial());

  Future<void> searchAnime(SearchAnimeRequest request) async {
    emit(AnimeLoading());

    try {
      final animes = await animeRepo.searchAnime(request);

      emit(AnimeListLoaded(animes));
    } catch (e) {
      emit(AnimeError(e.toString()));
    }
  }

  Future<void> getAllGenres() async {
    emit(GenreListLoading());

    try {
      final genres = await animeRepo.getAllGenres();

      emit(GenreListLoaded(genres));
    } catch (e) {
      emit(GenreError(e.toString()));
    }
  }

  void toggleGenre(int mal_id, bool selected) {
    if (state is! GenreListLoaded) return;

    final current = (state as GenreListLoaded).genres;

    final updated = current.map((genre) {
      if (genre.mal_id == mal_id) {
        return genre.copyWith(is_selected: selected);
      }

      return genre;
    }).toList();

    emit(GenreListLoaded(updated));
  }
}
