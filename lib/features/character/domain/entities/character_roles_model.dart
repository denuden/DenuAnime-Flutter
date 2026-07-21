import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';

class CharacterRolesModel {
  final String? role;
  final AnimeDetailsModel? anime;

  CharacterRolesModel({this.role, this.anime});

  factory CharacterRolesModel.fromJson(Map<String, dynamic> json) {
    return CharacterRolesModel(
      role: json['role'] as String?,
      anime: json['anime'] != null
          ? AnimeDetailsModel.fromJson(json['anime'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'role': role, 'anime': anime?.toJson()};
  }
}
