import 'package:denuanime/features/people/domain/entities/people_model.dart';

class PeopleState {
  final List<PeopleModel> peopleList;
  final PeopleModel peopleDetails;

  final bool isPeopleLoading;

  final String peopleListError;
  final String peopleError;

  const PeopleState({
    this.peopleList = const [],
    this.peopleDetails = const PeopleModel(),
    this.isPeopleLoading = false,
    this.peopleListError = "",
    this.peopleError = "",
  });

  PeopleState copyWith({
    List<PeopleModel>? peopleList,

    PeopleModel? peopleDetails,
    bool? isPeopleLoading,
    String? peopleListError,
    String? peopleError,
  }) {
    return PeopleState(
      peopleList: peopleList ?? this.peopleList,
      peopleDetails: peopleDetails ?? this.peopleDetails,
      isPeopleLoading: isPeopleLoading ?? this.isPeopleLoading,
      peopleListError: peopleListError ?? this.peopleListError,
      peopleError: peopleError ?? this.peopleError,
    );
  }
}
