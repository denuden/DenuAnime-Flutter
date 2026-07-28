import 'package:denuanime/features/people/domain/entities/people_model.dart';

abstract class PeopleState {}

class PeopleInitial extends PeopleState {}

class PeopleLoading extends PeopleState {}

class PeopleListLoaded extends PeopleState {
  final List<PeopleModel> people;

  PeopleListLoaded(this.people);
}

class PeopleDetailsLoaded extends PeopleState {
  final PeopleModel people;

  PeopleDetailsLoaded(this.people);
}

class PeopleError extends PeopleState {
  final String message;

  PeopleError(this.message);
}
