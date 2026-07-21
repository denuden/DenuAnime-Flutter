import 'package:denuanime/features/anime/domain/entities/voice_actor_model.dart';
import 'package:denuanime/features/character/domain/entities/character_roles_model.dart';
import 'package:denuanime/features/common/entities/image_type_model.dart';

class CharacterFullModel {
  final int? mal_id;
  final String? url;
  final ImageTypeModel? images;
  final String? name;
  final String? name_kanji;
  final List<String>? nicknames;
  final int? favorites;
  final String? about;
  final List<CharacterRolesModel>? anime;
  final List<VoiceActorModel>? voices;

  CharacterFullModel({
    this.mal_id,
    this.url,
    this.images,
    this.name,
    this.name_kanji,
    this.nicknames,
    this.favorites,
    this.about,
    this.anime,
    this.voices,
  });

  factory CharacterFullModel.fromJson(Map<String, dynamic> json) {
    return CharacterFullModel(
      mal_id: json['mal_id'] as int?,
      url: json['url'] as String?,
      images: json['images'] != null
          ? ImageTypeModel.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      name: json['name'] as String?,
      name_kanji: json['name_kanji'] as String?,
      nicknames: (json['nicknames'] as List?)?.map((e) => e as String).toList(),
      favorites: json['favorites'] as int?,
      about: json['about'] as String?,
      anime: (json['anime'] as List?)
          ?.map((e) => CharacterRolesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      voices: (json['voices'] as List?)
          ?.map((e) => VoiceActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': mal_id,
      'url': url,
      'images': images?.toJson(),
      'name': name,
      'name_kanji': name_kanji,
      'nicknames': nicknames,
      'favorites': favorites,
      'about': about,
      'anime': anime?.map((e) => e.toJson()).toList(),
      'voices': voices?.map((e) => e.toJson()).toList(),
    };
  }
}
