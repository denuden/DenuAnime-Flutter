import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';

class PeopleAnimeModel {
  final String? position;
  final AnimeDetailsModel? anime;

  PeopleAnimeModel({this.position, this.anime});

  factory PeopleAnimeModel.fromJson(Map<String, dynamic> json) {
    return PeopleAnimeModel(
      position: json['position'] as String?,
      anime: json['anime'] as AnimeDetailsModel?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'position': position, 'anime': AnimeDetailsModel};
  }
}
