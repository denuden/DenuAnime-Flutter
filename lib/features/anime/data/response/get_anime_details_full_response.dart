import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';

class GetAnimeDetailsFullResponse {
  final AnimeDetailsModel? data;

  const GetAnimeDetailsFullResponse({this.data});

  factory GetAnimeDetailsFullResponse.fromJson(Map<String, dynamic> json) {
    return GetAnimeDetailsFullResponse(
      data: json['data'] != null
          ? AnimeDetailsModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
