import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/features/people/presentation/cubits/people_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final PeopleRepo peopleRepo;

  PeopleCubit({required this.peopleRepo}) : super(const PeopleState());

  Future<void> searchPeople(SearchPeopleRequest request) async {
    emit(state.copyWith(isPeopleLoading: true, peopleListError: ""));

    try {
      final people = await peopleRepo.searchPeople(request);

      emit(
        state.copyWith(
          peopleList: people,
          isPeopleLoading: false,
          peopleListError: "",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isPeopleLoading: false, peopleListError: e.toString()),
      );
    }
  }
}
