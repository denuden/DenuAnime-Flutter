import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/episode_model.dart';

class RecentEpisodesModel {
  final AnimeDetailsModel? entry;
  final List<EpisodeModel>? episodes;
  final bool? regionLocked;

  const RecentEpisodesModel({
    required this.entry,
    required this.episodes,
    required this.regionLocked,
  });

  factory RecentEpisodesModel.fromJson(Map<String, dynamic> json) {
    return RecentEpisodesModel(
      entry: json['entry'] != null
          ? AnimeDetailsModel.fromJson(json['entry'] as Map<String, dynamic>)
          : null,
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      regionLocked: json['region_locked'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry?.toJson(),
      'episodes': episodes?.map((e) => e.toJson()).toList(),
      'region_locked': regionLocked,
    };
  }
}
