import 'package:denuanime/features/common/entities/image_type_model.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/utils/core/async_value.dart';

class PeopleState {
  final Async<List<PeopleModel>> people;
  final Async<PeopleModel> personDetails;
  final Async<List<ImageTypeModel>> pictures;

  const PeopleState({
    this.people = const AsyncIdle(),
    this.personDetails = const AsyncIdle(),
    this.pictures = const AsyncIdle(),
  });

  PeopleState copyWith({
    Async<List<PeopleModel>>? people,
    Async<PeopleModel>? personDetails,
    Async<List<ImageTypeModel>>? pictures,
  }) {
    return PeopleState(
      people: people ?? this.people,
      personDetails: personDetails ?? this.personDetails,
      pictures: pictures ?? this.pictures,
    );
  }
}
