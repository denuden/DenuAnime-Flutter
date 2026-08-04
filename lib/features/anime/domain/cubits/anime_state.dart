import 'package:denuanime/features/anime/domain/entities/anime_characters_model.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';

class AnimeState {
  final List<AnimeDetailsModel> animesList;
  final List<GenreModel> genresList;
  final List<RecommendationModel> recommendationList;
  final AnimeDetailsModel animeDetails;
  final List<AnimeCharactersModel> charactersList;

  final bool isAnimeLoading;
  final bool isGenreLoading;
  final bool isRecommendationLoading;
  final bool isAnimeDetailsLoading;
  final bool isCharactersListLoading;

  final String animeListError;
  final String genreListError;
  final String recommendationListError;
  final String animeDetailsError;
  final String charactersListError;

  final String animeInitial;

  const AnimeState({
    this.animeInitial = "",
    this.animesList = const [],
    this.genresList = const [],
    this.recommendationList = const [],
    this.animeDetails = const AnimeDetailsModel(),
    this.charactersList = const [],
    this.isAnimeLoading = false,
    this.isGenreLoading = false,
    this.isRecommendationLoading = false,
    this.isAnimeDetailsLoading = false,
    this.isCharactersListLoading = false,
    this.animeListError = "",
    this.genreListError = "",
    this.recommendationListError = "",
    this.animeDetailsError = "",
    this.charactersListError = "",
  });

  AnimeState copyWith({
    List<AnimeDetailsModel>? animesList,
    List<GenreModel>? genresList,
    List<RecommendationModel>? recommendationList,
    AnimeDetailsModel? animeDetails,
    List<AnimeCharactersModel>? charactersList,
    bool? isAnimeLoading,
    bool? isGenreLoading,
    bool? isRecommendationLoading,
    bool? isAnimeDetailsLoading,
    bool? isCharactersListLoading,
    String? animeListError,
    String? genreListError,
    String? recommendationListError,
    String? animeDetailsError,
    String? charactersListError,
    String? animeInitial,
  }) {
    return AnimeState(
      animesList: animesList ?? this.animesList,
      genresList: genresList ?? this.genresList,
      recommendationList: recommendationList ?? this.recommendationList,
      animeDetails: animeDetails ?? this.animeDetails,
      charactersList: charactersList ?? this.charactersList,

      isAnimeLoading: isAnimeLoading ?? this.isAnimeLoading,
      isGenreLoading: isGenreLoading ?? this.isGenreLoading,
      isRecommendationLoading:
          isRecommendationLoading ?? this.isRecommendationLoading,
      isAnimeDetailsLoading:
          isAnimeDetailsLoading ?? this.isAnimeDetailsLoading,
      isCharactersListLoading:
          isCharactersListLoading ?? this.isCharactersListLoading,

      animeListError: animeListError ?? this.animeListError,
      genreListError: genreListError ?? this.genreListError,
      recommendationListError:
          recommendationListError ?? this.recommendationListError,
      animeDetailsError: animeDetailsError ?? this.animeDetailsError,
      charactersListError: charactersListError ?? this.charactersListError,

      animeInitial: animeInitial ?? this.animeInitial,
    );
  }
}
