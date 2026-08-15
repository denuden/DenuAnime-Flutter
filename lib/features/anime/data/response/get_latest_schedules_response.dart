import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/common/entities/pagination_model.dart';

class GetLatestSchedulesResponse {
  final PaginationModel? pagination;
  final List<AnimeDetailsModel>? data;

  const GetLatestSchedulesResponse({this.pagination, this.data});

  factory GetLatestSchedulesResponse.fromJson(Map<String, dynamic> json) {
    return GetLatestSchedulesResponse(
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      data: (json['data'] as List?)
          ?.map((e) => AnimeDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
