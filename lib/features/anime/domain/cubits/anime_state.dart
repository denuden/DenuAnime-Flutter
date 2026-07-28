import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';

abstract class AnimeState {}

class AnimeInitial extends AnimeState {}

class AnimeLoading extends AnimeState {}

class AnimeListLoaded extends AnimeState {
  final List<AnimeDetailsModel> animes;

  AnimeListLoaded(this.animes);
}

//* ========= Genre
class GenreListLoading extends AnimeState {}

class GenreListLoaded extends AnimeState {
  final List<GenreModel> genres;

  GenreListLoaded(this.genres);
}

class GenreError extends AnimeState {
  final String message;

  GenreError(this.message);
}

class AnimeError extends AnimeState {
  final String message;

  AnimeError(this.message);
}
