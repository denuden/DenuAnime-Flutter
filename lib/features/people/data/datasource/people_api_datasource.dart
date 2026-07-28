import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/data/response/search_people_response.dart';
import 'package:dio/dio.dart';

class PeopleApiDatasource {
  final Dio dio;

  PeopleApiDatasource(this.dio);

  Future<SearchPeopleResponse> searchPeople(SearchPeopleRequest request) async {
    final response = await dio.get<Map<String, dynamic>>(
      "/people",
      queryParameters: request.toQueryParameters(),
    );

    return SearchPeopleResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
