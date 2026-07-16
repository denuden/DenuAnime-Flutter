import 'package:denuanime/features/anime/domain/entities/aired_model.dart';
import 'package:denuanime/features/anime/domain/entities/broadcast_model.dart';
import 'package:denuanime/features/anime/domain/entities/external_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/entities/licensor_model.dart';
import 'package:denuanime/features/anime/domain/entities/producer_model.dart';
import 'package:denuanime/features/anime/domain/entities/relation_model.dart';
import 'package:denuanime/features/anime/domain/entities/streaming_model.dart';
import 'package:denuanime/features/anime/domain/entities/studio_model.dart';
import 'package:denuanime/features/anime/domain/entities/theme_song_model.dart';
import 'package:denuanime/features/anime/domain/entities/title_model.dart';
import 'package:denuanime/features/anime/domain/entities/trailer_model.dart';
import 'package:denuanime/features/common/entities/image_type_model.dart';

class AnimeDetailsModel {
  final int? malId;
  final String? url;
  final ImageTypeModel? images;
  final TrailerModel? trailer;
  final bool? approved;
  final List<TitleModel>? titles;
  final String? title;
  final String? titleEnglish;
  final String? titleJapanese;
  final List<String>? titleSynonyms;
  final String? type;
  final String? source;
  final int? episodes;
  final String? status;
  final bool? airing;
  final AiredModel? aired;
  final String? duration;
  final String? rating;
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int? popularity;
  final int? members;
  final int? favorites;
  final String? synopsis;
  final String? background;
  final String? season;
  final int? year;
  final BroadcastModel? broadcast;
  final List<ProducerModel>? producers;
  final List<LicensorModel>? licensors;
  final List<StudioModel>? studios;
  final List<GenreModel>? genres;
  final List<dynamic>? explicitGenres;
  final List<GenreModel>? themes;
  final List<GenreModel>? demographics;
  final List<RelationModel>? relations;
  final ThemeSongModel? theme;
  final List<ExternalModel>? external;
  final List<StreamingModel>? streaming;

  const AnimeDetailsModel({
    this.malId,
    this.url,
    this.images,
    this.trailer,
    this.approved,
    this.titles,
    this.title,
    this.titleEnglish,
    this.titleJapanese,
    this.titleSynonyms,
    this.type,
    this.source,
    this.episodes,
    this.status,
    this.airing,
    this.aired,
    this.duration,
    this.rating,
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    this.synopsis,
    this.background,
    this.season,
    this.year,
    this.broadcast,
    this.producers,
    this.licensors,
    this.studios,
    this.genres,
    this.explicitGenres,
    this.themes,
    this.demographics,
    this.relations,
    this.theme,
    this.external,
    this.streaming,
  });

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) {
    return AnimeDetailsModel(
      malId: json['mal_id'] as int?,
      url: json['url'] as String?,
      images: json['images'] != null
          ? ImageTypeModel.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      trailer: json['trailer'] != null
          ? TrailerModel.fromJson(json['trailer'] as Map<String, dynamic>)
          : null,
      approved: json['approved'] as bool?,
      titles: (json['titles'] as List?)
          ?.map((e) => TitleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      titleEnglish: json['title_english'] as String?,
      titleJapanese: json['title_japanese'] as String?,
      titleSynonyms: (json['title_synonyms'] as List?)
          ?.map((e) => e as String)
          .toList(),
      type: json['type'] as String?,
      source: json['source'] as String?,
      episodes: json['episodes'] as int?,
      status: json['status'] as String?,
      airing: json['airing'] as bool?,
      aired: json['aired'] != null
          ? AiredModel.fromJson(json['aired'] as Map<String, dynamic>)
          : null,
      duration: json['duration'] as String?,
      rating: json['rating'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      scoredBy: json['scored_by'] as int?,
      rank: json['rank'] as int?,
      popularity: json['popularity'] as int?,
      members: json['members'] as int?,
      favorites: json['favorites'] as int?,
      synopsis: json['synopsis'] as String?,
      background: json['background'] as String?,
      season: json['season'] as String?,
      year: json['year'] as int?,
      broadcast: json['broadcast'] != null
          ? BroadcastModel.fromJson(json['broadcast'] as Map<String, dynamic>)
          : null,
      producers: (json['producers'] as List?)
          ?.map((e) => ProducerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      licensors: (json['licensors'] as List?)
          ?.map((e) => LicensorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      studios: (json['studios'] as List?)
          ?.map((e) => StudioModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      explicitGenres: json['explicit_genres'] as List?,
      themes: (json['themes'] as List?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      demographics: (json['demographics'] as List?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      relations: (json['relations'] as List?)
          ?.map((e) => RelationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      theme: json['theme'] != null
          ? ThemeSongModel.fromJson(json['theme'] as Map<String, dynamic>)
          : null,
      external: (json['external'] as List?)
          ?.map((e) => ExternalModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      streaming: (json['streaming'] as List?)
          ?.map((e) => StreamingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'url': url,
      'images': images?.toJson(),
      'trailer': trailer?.toJson(),
      'approved': approved,
      'titles': titles?.map((e) => e.toJson()).toList(),
      'title': title,
      'title_english': titleEnglish,
      'title_japanese': titleJapanese,
      'title_synonyms': titleSynonyms,
      'type': type,
      'source': source,
      'episodes': episodes,
      'status': status,
      'airing': airing,
      'aired': aired?.toJson(),
      'duration': duration,
      'rating': rating,
      'score': score,
      'scored_by': scoredBy,
      'rank': rank,
      'popularity': popularity,
      'members': members,
      'favorites': favorites,
      'synopsis': synopsis,
      'background': background,
      'season': season,
      'year': year,
      'broadcast': broadcast?.toJson(),
      'producers': producers?.map((e) => e.toJson()).toList(),
      'licensors': licensors?.map((e) => e.toJson()).toList(),
      'studios': studios?.map((e) => e.toJson()).toList(),
      'genres': genres?.map((e) => e.toJson()).toList(),
      'explicit_genres': explicitGenres,
      'themes': themes?.map((e) => e.toJson()).toList(),
      'demographics': demographics?.map((e) => e.toJson()).toList(),
      'relations': relations?.map((e) => e.toJson()).toList(),
      'theme': theme?.toJson(),
      'external': external?.map((e) => e.toJson()).toList(),
      'streaming': streaming?.map((e) => e.toJson()).toList(),
    };
  }
}
