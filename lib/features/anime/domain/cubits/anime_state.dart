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
  final List<AnimeDetailsModel> latestSchedulesList;
  final List<AnimeDetailsModel> seasonalAnimeCurrentList;
  final List<AnimeDetailsModel> seasonalAnimeUpcomingList;

  final bool isAnimeLoading;
  final bool isGenreLoading;
  final bool isRecommendationLoading;
  final bool isAnimeDetailsLoading;
  final bool isCharactersListLoading;
  final bool isLatestSchedulesLoading;
  final bool isSeasonalAnimeCurrentListLoading;
  final bool isSeasonalAnimeUpcomingListLoading;

  final String animeListError;
  final String genreListError;
  final String recommendationListError;
  final String animeDetailsError;
  final String charactersListError;
  final String latestSchedulesListError;
  final String seasonalAnimeCurrentListError;
  final String seasonalAnimeUpcomingListError;

  final String animeInitial;

  const AnimeState({
    this.animeInitial = "",
    this.animesList = const [],
    this.genresList = const [],
    this.recommendationList = const [],
    this.animeDetails = const AnimeDetailsModel(),
    this.charactersList = const [],
    this.latestSchedulesList = const [],
    this.seasonalAnimeCurrentList = const [],
    this.seasonalAnimeUpcomingList = const [],

    this.isAnimeLoading = false,
    this.isGenreLoading = false,
    this.isRecommendationLoading = false,
    this.isAnimeDetailsLoading = false,
    this.isCharactersListLoading = false,
    this.isLatestSchedulesLoading = false,
    this.isSeasonalAnimeCurrentListLoading = false,
    this.isSeasonalAnimeUpcomingListLoading = false,

    this.animeListError = "",
    this.genreListError = "",
    this.recommendationListError = "",
    this.animeDetailsError = "",
    this.charactersListError = "",
    this.latestSchedulesListError = "",
    this.seasonalAnimeCurrentListError = "",
    this.seasonalAnimeUpcomingListError = "",
  });

  AnimeState copyWith({
    List<AnimeDetailsModel>? animesList,
    List<GenreModel>? genresList,
    List<RecommendationModel>? recommendationList,
    AnimeDetailsModel? animeDetails,
    List<AnimeCharactersModel>? charactersList,
    List<AnimeDetailsModel>? latestSchedulesList,
    List<AnimeDetailsModel>? seasonalAnimeCurrentList,
    List<AnimeDetailsModel>? seasonalAnimeUpcomingList,

    bool? isAnimeLoading,
    bool? isGenreLoading,
    bool? isRecommendationLoading,
    bool? isAnimeDetailsLoading,
    bool? isCharactersListLoading,
    bool? isLatestSchedulesLoading,
    bool? isSeasonalAnimeCurrentListLoading,
    bool? isSeasonalAnimeUpcomingListLoading,

    String? animeListError,
    String? genreListError,
    String? recommendationListError,
    String? animeDetailsError,
    String? charactersListError,
    String? latestSchedulesListError,
    String? seasonalAnimeCurrentListError,
    String? seasonalAnimeUpcomingListError,

    String? animeInitial,
  }) {
    return AnimeState(
      animesList: animesList ?? this.animesList,
      genresList: genresList ?? this.genresList,
      recommendationList: recommendationList ?? this.recommendationList,
      animeDetails: animeDetails ?? this.animeDetails,
      charactersList: charactersList ?? this.charactersList,
      latestSchedulesList: latestSchedulesList ?? this.latestSchedulesList,
      seasonalAnimeCurrentList:
          seasonalAnimeCurrentList ?? this.seasonalAnimeCurrentList,

      isAnimeLoading: isAnimeLoading ?? this.isAnimeLoading,
      isGenreLoading: isGenreLoading ?? this.isGenreLoading,
      isRecommendationLoading:
          isRecommendationLoading ?? this.isRecommendationLoading,
      isAnimeDetailsLoading:
          isAnimeDetailsLoading ?? this.isAnimeDetailsLoading,
      isCharactersListLoading:
          isCharactersListLoading ?? this.isCharactersListLoading,
      isLatestSchedulesLoading:
          isLatestSchedulesLoading ?? this.isLatestSchedulesLoading,
      isSeasonalAnimeCurrentListLoading:
          isSeasonalAnimeCurrentListLoading ??
          this.isSeasonalAnimeCurrentListLoading,
      isSeasonalAnimeUpcomingListLoading:
          isSeasonalAnimeUpcomingListLoading ??
          this.isSeasonalAnimeUpcomingListLoading,

      animeListError: animeListError ?? this.animeListError,
      genreListError: genreListError ?? this.genreListError,
      recommendationListError:
          recommendationListError ?? this.recommendationListError,
      animeDetailsError: animeDetailsError ?? this.animeDetailsError,
      charactersListError: charactersListError ?? this.charactersListError,
      latestSchedulesListError:
          latestSchedulesListError ?? this.latestSchedulesListError,
      seasonalAnimeCurrentListError:
          seasonalAnimeCurrentListError ?? this.seasonalAnimeCurrentListError,
      seasonalAnimeUpcomingListError:
          seasonalAnimeUpcomingListError ?? this.seasonalAnimeUpcomingListError,

      animeInitial: animeInitial ?? this.animeInitial,
    );
  }
}
