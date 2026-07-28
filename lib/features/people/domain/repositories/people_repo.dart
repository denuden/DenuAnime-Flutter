import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';

abstract class PeopleRepo {
  Future<List<PeopleModel>> searchPeople(SearchPeopleRequest request);
}
