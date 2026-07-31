import 'package:flutter/widgets.dart';

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
  final int? mal_id;
  final String? url;
  final ImageTypeModel? images;
  final TrailerModel? trailer;
  final bool? approved;
  final List<TitleModel>? titles;
  final String? title;
  final String? title_english;
  final String? title_japanese;
  final List<String>? title_synonyms;
  final String? type;
  final String? source;
  final int? episodes;
  final String? status;
  final bool? airing;
  final AiredModel? aired;
  final String? duration;
  final String? rating;
  final double? score;
  final int? scored_by;
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
  final List<dynamic>? explicit_genres;
  final List<GenreModel>? themes;
  final List<GenreModel>? demographics;
  final List<RelationModel>? relations;
  final ThemeSongModel? theme;
  final List<ExternalModel>? external;
  final List<StreamingModel>? streaming;

  const AnimeDetailsModel({
    this.mal_id,
    this.url,
    this.images,
    this.trailer,
    this.approved,
    this.titles,
    this.title,
    this.title_english,
    this.title_japanese,
    this.title_synonyms,
    this.type,
    this.source,
    this.episodes,
    this.status,
    this.airing,
    this.aired,
    this.duration,
    this.rating,
    this.score,
    this.scored_by,
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
    this.explicit_genres,
    this.themes,
    this.demographics,
    this.relations,
    this.theme,
    this.external,
    this.streaming,
  });

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) {
    return AnimeDetailsModel(
      mal_id: json['mal_id'] as int?,
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
      title_english: json['title_english'] as String?,
      title_japanese: json['title_japanese'] as String?,
      title_synonyms: (json['title_synonyms'] as List?)
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
      scored_by: json['scored_by'] as int?,
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
      explicit_genres: json['explicit_genres'] as List?,
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
      'mal_id': mal_id,
      'url': url,
      'images': images?.toJson(),
      'trailer': trailer?.toJson(),
      'approved': approved,
      'titles': titles?.map((e) => e.toJson()).toList(),
      'title': title,
      'title_english': title_english,
      'title_japanese': title_japanese,
      'title_synonyms': title_synonyms,
      'type': type,
      'source': source,
      'episodes': episodes,
      'status': status,
      'airing': airing,
      'aired': aired?.toJson(),
      'duration': duration,
      'rating': rating,
      'score': score,
      'scored_by': scored_by,
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
      'explicit_genres': explicit_genres,
      'themes': themes?.map((e) => e.toJson()).toList(),
      'demographics': demographics?.map((e) => e.toJson()).toList(),
      'relations': relations?.map((e) => e.toJson()).toList(),
      'theme': theme?.toJson(),
      'external': external?.map((e) => e.toJson()).toList(),
      'streaming': streaming?.map((e) => e.toJson()).toList(),
    };
  }

  AnimeDetailsModel copyWith({
    ValueGetter<int?>? mal_id,
    ValueGetter<String?>? url,
    ValueGetter<ImageTypeModel?>? images,
    ValueGetter<TrailerModel?>? trailer,
    ValueGetter<bool?>? approved,
    ValueGetter<List<TitleModel>?>? titles,
    ValueGetter<String?>? title,
    ValueGetter<String?>? title_english,
    ValueGetter<String?>? title_japanese,
    ValueGetter<List<String>?>? title_synonyms,
    ValueGetter<String?>? type,
    ValueGetter<String?>? source,
    ValueGetter<int?>? episodes,
    ValueGetter<String?>? status,
    ValueGetter<bool?>? airing,
    ValueGetter<AiredModel?>? aired,
    ValueGetter<String?>? duration,
    ValueGetter<String?>? rating,
    ValueGetter<double?>? score,
    ValueGetter<int?>? scored_by,
    ValueGetter<int?>? rank,
    ValueGetter<int?>? popularity,
    ValueGetter<int?>? members,
    ValueGetter<int?>? favorites,
    ValueGetter<String?>? synopsis,
    ValueGetter<String?>? background,
    ValueGetter<String?>? season,
    ValueGetter<int?>? year,
    ValueGetter<BroadcastModel?>? broadcast,
    ValueGetter<List<ProducerModel>?>? producers,
    ValueGetter<List<LicensorModel>?>? licensors,
    ValueGetter<List<StudioModel>?>? studios,
    ValueGetter<List<GenreModel>?>? genres,
    ValueGetter<List<dynamic>?>? explicit_genres,
    ValueGetter<List<GenreModel>?>? themes,
    ValueGetter<List<GenreModel>?>? demographics,
    ValueGetter<List<RelationModel>?>? relations,
    ValueGetter<ThemeSongModel?>? theme,
    ValueGetter<List<ExternalModel>?>? external,
    ValueGetter<List<StreamingModel>?>? streaming,
  }) {
    return AnimeDetailsModel(
      mal_id: mal_id != null ? mal_id() : this.mal_id,
      url: url != null ? url() : this.url,
      images: images != null ? images() : this.images,
      trailer: trailer != null ? trailer() : this.trailer,
      approved: approved != null ? approved() : this.approved,
      titles: titles != null ? titles() : this.titles,
      title: title != null ? title() : this.title,
      title_english: title_english != null
          ? title_english()
          : this.title_english,
      title_japanese: title_japanese != null
          ? title_japanese()
          : this.title_japanese,
      title_synonyms: title_synonyms != null
          ? title_synonyms()
          : this.title_synonyms,
      type: type != null ? type() : this.type,
      source: source != null ? source() : this.source,
      episodes: episodes != null ? episodes() : this.episodes,
      status: status != null ? status() : this.status,
      airing: airing != null ? airing() : this.airing,
      aired: aired != null ? aired() : this.aired,
      duration: duration != null ? duration() : this.duration,
      rating: rating != null ? rating() : this.rating,
      score: score != null ? score() : this.score,
      scored_by: scored_by != null ? scored_by() : this.scored_by,
      rank: rank != null ? rank() : this.rank,
      popularity: popularity != null ? popularity() : this.popularity,
      members: members != null ? members() : this.members,
      favorites: favorites != null ? favorites() : this.favorites,
      synopsis: synopsis != null ? synopsis() : this.synopsis,
      background: background != null ? background() : this.background,
      season: season != null ? season() : this.season,
      year: year != null ? year() : this.year,
      broadcast: broadcast != null ? broadcast() : this.broadcast,
      producers: producers != null ? producers() : this.producers,
      licensors: licensors != null ? licensors() : this.licensors,
      studios: studios != null ? studios() : this.studios,
      genres: genres != null ? genres() : this.genres,
      explicit_genres: explicit_genres != null
          ? explicit_genres()
          : this.explicit_genres,
      themes: themes != null ? themes() : this.themes,
      demographics: demographics != null ? demographics() : this.demographics,
      relations: relations != null ? relations() : this.relations,
      theme: theme != null ? theme() : this.theme,
      external: external != null ? external() : this.external,
      streaming: streaming != null ? streaming() : this.streaming,
    );
  }
}
