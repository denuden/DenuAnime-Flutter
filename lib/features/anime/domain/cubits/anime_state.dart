import 'package:denuanime/features/anime/domain/entities/anime_characters_model.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';
import 'package:denuanime/utils/core/async_value.dart';

///In Compose, a composable only redraws when what you passed into it changes.
/// Pass one field, and it only redraws when that field changes.
/// In Bloc, everything listens to the whole state object.
/// So change one field and everything rebuilds, even the parts that don't use it.
/// buildWhen is how you say which field you actually care about.
/// Same goal, but Compose figures it out from what you passed in, and Bloc makes you say it.
/// "whole state object, not individual fields."
///
/// In Compose, a composable skips recomposition when its arguments haven't changed —
/// so if I pass one field down, that part of the UI only redraws when that field changes. It's automatic.
/// In Bloc, the state is one object with one stream. When any field changes,
/// every BlocBuilder on that cubit rebuilds, even the ones reading unrelated fields.
/// So I use buildWhen to say which field a builder actually depends on.
/// Same idea in both — only redraw what changed.
///  Compose infers it from the parameters, Bloc makes you declare it.
/// == compares the whole state, so it only stops emits where nothing changed at all.
///  It can't tell one builder that the part it cares about is unchanged.
/// That's a per-field question, and that's what buildWhen answers.
class AnimeState {
  final Async<List<GenreModel>> genres;
  final Async<List<AnimeDetailsModel>> animes;
  final Async<List<RecommendationModel>> recommendations;
  final Async<List<AnimeDetailsModel>> recents;

  final AnimeDetailsModel animeDetails;
  final List<AnimeCharactersModel> charactersList;

  final bool hasNextPage;
  final bool isLoadingMore;

  final bool isAnimeDetailsLoading;
  final bool isCharactersListLoading;

  final String animeDetailsError;
  final String charactersListError;

  final String animeInitial;

  const AnimeState({
    this.genres = const AsyncIdle(),

    this.animes = const AsyncIdle(),
    this.hasNextPage = false,
    this.isLoadingMore = false,

    this.recommendations = const AsyncIdle(),

    this.recents = const AsyncIdle(),

    this.animeInitial = "",
    this.animeDetails = const AnimeDetailsModel(),
    this.charactersList = const [],

    this.isAnimeDetailsLoading = false,
    this.isCharactersListLoading = false,

    this.animeDetailsError = "",
    this.charactersListError = "",
  });

  AnimeState copyWith({
    Async<List<GenreModel>>? genres,

    Async<List<AnimeDetailsModel>>? animes,
    bool? hasNextPage,
    bool? isLoadingMore,

    Async<List<RecommendationModel>>? recommendations,

    Async<List<AnimeDetailsModel>>? recents,

    AnimeDetailsModel? animeDetails,
    List<AnimeCharactersModel>? charactersList,

    bool? isAnimeDetailsLoading,
    bool? isCharactersListLoading,

    String? animeDetailsError,
    String? charactersListError,

    String? animeInitial,
  }) {
    return AnimeState(
      genres: genres ?? this.genres,

      animes: animes ?? this.animes,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,

      recommendations: recommendations ?? this.recommendations,

      recents: recents ?? this.recents,

      animeDetails: animeDetails ?? this.animeDetails,
      charactersList: charactersList ?? this.charactersList,

      isAnimeDetailsLoading:
          isAnimeDetailsLoading ?? this.isAnimeDetailsLoading,
      isCharactersListLoading:
          isCharactersListLoading ?? this.isCharactersListLoading,

      animeDetailsError: animeDetailsError ?? this.animeDetailsError,
      charactersListError: charactersListError ?? this.charactersListError,

      animeInitial: animeInitial ?? this.animeInitial,
    );
  }
}
