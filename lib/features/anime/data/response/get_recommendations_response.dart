import 'package:denuanime/features/anime/domain/entities/recommendation_model.dart';
import 'package:denuanime/features/common/entities/pagination_model.dart';

class GetRecommendationsResponse {
  final PaginationModel? pagination;
  final List<RecommendationModel>? data;

  const GetRecommendationsResponse({this.pagination, this.data});

  factory GetRecommendationsResponse.fromJson(Map<String, dynamic> json) {
    return GetRecommendationsResponse(
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,

      data: (json['data'] as List?)
          ?.map((e) => RecommendationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
