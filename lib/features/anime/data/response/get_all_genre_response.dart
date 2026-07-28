import 'package:denuanime/features/anime/domain/entities/genre_model.dart';

class GetAllGenreResponse {
  final List<GenreModel>? data;

  const GetAllGenreResponse({this.data});

  factory GetAllGenreResponse.fromJson(Map<String, dynamic> json) {
    return GetAllGenreResponse(
      data: (json['data'] as List?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
