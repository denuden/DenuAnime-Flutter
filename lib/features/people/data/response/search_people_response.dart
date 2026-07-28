import 'package:denuanime/features/common/entities/pagination_model.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';

class SearchPeopleResponse {
  final PaginationModel? pagination;
  final List<PeopleModel>? data;

  const SearchPeopleResponse({this.pagination, this.data});

  factory SearchPeopleResponse.fromJson(Map<String, dynamic> json) {
    return SearchPeopleResponse(
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      data: (json['data'] as List?)
          ?.map((e) => PeopleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
