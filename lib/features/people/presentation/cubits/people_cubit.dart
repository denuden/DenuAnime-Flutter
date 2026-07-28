import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/features/people/presentation/cubits/people_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final PeopleRepo peopleRepo;

  PeopleCubit({required this.peopleRepo}) : super(PeopleInitial());

  Future<void> searchPeople(SearchPeopleRequest request) async {
    emit(PeopleLoading());

    try {
      final people = await peopleRepo.searchPeople(request);

      emit(PeopleListLoaded(people));
    } catch (e) {
      emit(PeopleError(e.toString()));
    }
  }
}
