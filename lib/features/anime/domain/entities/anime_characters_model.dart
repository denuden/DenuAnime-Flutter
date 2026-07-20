import 'package:denuanime/features/anime/domain/entities/voice_actor_model.dart';
import 'package:denuanime/features/people/domain/entities/character_model.dart';

class AnimeCharactersModel {
  final CharacterModel? character;
  final String? role;
  final int? favorites;
  final List<VoiceActorModel>? voice_actors;

  AnimeCharactersModel({
    this.character,
    this.role,
    this.favorites,
    this.voice_actors,
  });

  factory AnimeCharactersModel.fromJson(Map<String, dynamic> json) {
    return AnimeCharactersModel(
      character: json['character'] != null
          ? CharacterModel.fromJson(json['character'] as Map<String, dynamic>)
          : null,
      role: json['role'] as String?,
      favorites: json['favorites'] as int?,
      voice_actors: (json['voice_actors'] as List?)
          ?.map((e) => VoiceActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character': character?.toJson(),
      'role': role,
      'favorites': favorites,
      'voice_actors': voice_actors?.map((e) => e.toJson()).toList(),
    };
  }
}
