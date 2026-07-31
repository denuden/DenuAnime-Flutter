import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';

class AnimeState {
  final List<AnimeDetailsModel> animesList;
  final List<GenreModel> genresList;
  final List<RecommendationModel> recommendationList;
  final AnimeDetailsModel animeDetails;

  final bool isAnimeLoading;
  final bool isGenreLoading;
  final bool isRecommendationLoading;
  final bool isAnimeDetailsLoading;

  final String animeListError;
  final String genreListError;
  final String recommendationListError;
  final String animeDetailsError;

  final String animeInitial;

  const AnimeState({
    this.animeInitial = "",
    this.animesList = const [],
    this.genresList = const [],
    this.recommendationList = const [],
    this.animeDetails = const AnimeDetailsModel(),
    this.isAnimeLoading = false,
    this.isGenreLoading = false,
    this.isRecommendationLoading = false,
    this.isAnimeDetailsLoading = false,
    this.animeListError = "",
    this.genreListError = "",
    this.recommendationListError = "",
    this.animeDetailsError = "",
  });

  AnimeState copyWith({
    List<AnimeDetailsModel>? animesList,
    List<GenreModel>? genresList,
    List<RecommendationModel>? recommendationList,
    AnimeDetailsModel? animeDetails,
    bool? isAnimeLoading,
    bool? isGenreLoading,
    bool? isRecommendationLoading,
    bool? isAnimeDetailsLoading,
    String? animeListError,
    String? genreListError,
    String? recommendationListError,
    String? animeDetailsError,
    String? animeInitial,
  }) {
    return AnimeState(
      animesList: animesList ?? this.animesList,
      genresList: genresList ?? this.genresList,
      recommendationList: recommendationList ?? this.recommendationList,
      animeDetails: animeDetails ?? this.animeDetails,
      isAnimeLoading: isAnimeLoading ?? this.isAnimeLoading,
      isGenreLoading: isGenreLoading ?? this.isGenreLoading,
      isRecommendationLoading:
          isRecommendationLoading ?? this.isRecommendationLoading,
      isAnimeDetailsLoading:
          isAnimeDetailsLoading ?? this.isAnimeDetailsLoading,
      animeListError: animeListError ?? this.animeListError,
      genreListError: genreListError ?? this.genreListError,
      recommendationListError:
          recommendationListError ?? this.recommendationListError,
      animeDetailsError: animeDetailsError ?? this.animeDetailsError,
      animeInitial: animeInitial ?? this.animeInitial,
    );
  }
}
