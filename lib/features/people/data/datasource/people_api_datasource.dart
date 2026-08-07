import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/data/response/get_people_details_response.dart';
import 'package:denuanime/features/people/data/response/get_pictures_response.dart';
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

  Future<GetPeopleDetailsResponse> getPeopleDetails(int id) async {
    final response = await dio.get<Map<String, dynamic>>("/people/$id");

    return GetPeopleDetailsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<GetPeopleDetailsResponse> getFullPeopleDetails(int id) async {
    final response = await dio.get<Map<String, dynamic>>("/people/$id/full");

    return GetPeopleDetailsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<GetPicturesResponse> getPictures(int id) async {
    final response = await dio.get<Map<String, dynamic>>(
      "/people/$id/pictures",
    );

    return GetPicturesResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
