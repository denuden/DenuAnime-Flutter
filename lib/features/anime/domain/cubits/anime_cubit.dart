import 'package:denuanime/features/anime/data/request/get_anime_details_full_request.dart';
import 'package:denuanime/features/anime/data/request/get_recommendations_request.dart';
import 'package:denuanime/features/anime/data/request/search_anime_request.dart';
import 'package:denuanime/features/anime/domain/repositories/anime_repo.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeCubit extends Cubit<AnimeState> {
  final AnimeRepo animeRepo;

  AnimeCubit({required this.animeRepo}) : super(const AnimeState());

  Future<void> searchAnime(SearchAnimeRequest request) async {
    emit(state.copyWith(isAnimeLoading: true, animeListError: ""));

    try {
      final animes = await animeRepo.searchAnime(request);

      emit(
        state.copyWith(
          animesList: animes,
          isAnimeLoading: false,
          animeListError: "",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isAnimeLoading: false, animeListError: e.toString()));
    }
  }

  Future<void> getAllGenres() async {
    emit(state.copyWith(isGenreLoading: true, genreListError: ""));

    try {
      final genres = await animeRepo.getAllGenres();

      emit(
        state.copyWith(
          genresList: genres,
          isGenreLoading: false,
          genreListError: "",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isGenreLoading: false, genreListError: e.toString()));
    }
  }

  Future<void> getAllRecommendations(GetRecommendationsRequest request) async {
    emit(
      state.copyWith(
        isRecommendationLoading: true,
        recommendationListError: "",
      ),
    );

    try {
      final recommendationList = await animeRepo.getRecommendations(request);

      emit(
        state.copyWith(
          recommendationList: recommendationList,
          isRecommendationLoading: false,
          recommendationListError: "",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          recommendationListError: e.toString(),
          isRecommendationLoading: false,
        ),
      );
    }
  }

  Future<void> getAnimeDetailsFull(GetAnimeDetailsFullRequest request) async {
    emit(state.copyWith(isAnimeDetailsLoading: true, animeDetailsError: ""));

    try {
      final animeDetails = await animeRepo.getAnimeDetailsFull(request);

      emit(
        state.copyWith(
          animeDetails: animeDetails,
          isAnimeDetailsLoading: false,
          animeDetailsError: "",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          animeDetailsError: e.toString(),
          isAnimeDetailsLoading: false,
        ),
      );
    }
  }

  //? ====================== local calls
  void toggleGenre(int malId, bool selected) {
    final updatedGenres = state.genresList.map((genre) {
      if (genre.mal_id == malId) {
        return genre.copyWith(is_selected: selected);
      }
      return genre;
    }).toList();

    emit(state.copyWith(genresList: updatedGenres));
  }
}
