import 'package:denuanime/features/anime/domain/entities/anime_characters_model.dart';

class GetAnimeCharactersResponse {
  final List<AnimeCharactersModel>? data;

  const GetAnimeCharactersResponse({this.data});

  factory GetAnimeCharactersResponse.fromJson(Map<String, dynamic> json) {
    return GetAnimeCharactersResponse(
      data: (json['data'] as List?)
          ?.map((e) => AnimeCharactersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
