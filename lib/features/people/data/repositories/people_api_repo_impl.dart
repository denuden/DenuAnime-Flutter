import 'dart:io';

import 'package:denuanime/features/people/data/datasource/people_api_datasource.dart';
import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';

class PeopleApiRepoImpl implements PeopleRepo {
  final PeopleApiDatasource api;

  PeopleApiRepoImpl(this.api);

  @override
  Future<List<PeopleModel>> searchPeople(SearchPeopleRequest request) async {
    final response = await api.searchPeople(request);

    if (response.data?.isNotEmpty == true && response.data != null) {
      return response.data ?? [];
    } else {
      throw const HttpException("No people found matching the details.");
    }
  }

  @override
  Future<PeopleModel> getPeopleDetails(int id) async {
    final response = await api.getPeopleDetails(id);

    if (response.data != null) {
      return response.data ?? const PeopleModel();
    } else {
      throw HttpException("No people found with id $id");
    }
  }
}
