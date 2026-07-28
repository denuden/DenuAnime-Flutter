import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/common/entities/pagination_model.dart';

class SearchAnimeResponse {
  final PaginationModel? pagination;
  final List<AnimeDetailsModel>? data;

  const SearchAnimeResponse({this.pagination, this.data});

  factory SearchAnimeResponse.fromJson(Map<String, dynamic> json) {
    return SearchAnimeResponse(
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      data: (json['data'] as List?)
          ?.map((e) => AnimeDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
