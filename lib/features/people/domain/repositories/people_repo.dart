import 'package:denuanime/features/common/entities/image_type_model.dart';
import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';

abstract class PeopleRepo {
  Future<List<PeopleModel>> searchPeople(SearchPeopleRequest request);
  Future<PeopleModel> getPeopleDetails(int id);
  Future<PeopleModel> getFullPeopleDetails(int id);
  Future<List<ImageTypeModel>> getPictures(int id);
}
