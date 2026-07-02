import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/people/domain/entities/character_model.dart';

class VoicesModel {
  final String? role;
  final AnimeDetailsModel? anime;
  final CharacterModel? character;

  const VoicesModel({this.role, this.anime, this.character});

  factory VoicesModel.fromJson(Map<String, dynamic> json) {
    return VoicesModel(
      role: json['role'] as String?,
      anime: json['anime'] != null
          ? AnimeDetailsModel.fromJson(json['anime'])
          : null,
      character: json['character'] != null
          ? CharacterModel.fromJson(json['character'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'anime': anime?.toJson(),
      'character': character?.toJson(),
    };
  }
}
