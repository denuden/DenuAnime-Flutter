import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/features/people/domain/cubits/people_state.dart';
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

  Future<void> getPeopleDetails(int id) async {
    emit(state.copyWith(isPeopleLoading: true, peopleError: ""));

    try {
      final people = await peopleRepo.getPeopleDetails(id);

      emit(
        state.copyWith(
          peopleDetails: people,
          isPeopleLoading: false,
          peopleError: "",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isPeopleLoading: false, peopleError: e.toString()));
    }
  }

  Future<void> getFullPeopleDetails(int id) async {
    emit(state.copyWith(isPeopleLoading: true, peopleError: ""));

    try {
      final people = await peopleRepo.getFullPeopleDetails(id);
      final pictures = await peopleRepo.getPictures(people.mal_id ?? -1);
      emit(
        state.copyWith(
          peopleDetails: people,
          pictures: pictures,
          isPeopleLoading: false,
          peopleError: "",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isPeopleLoading: false, peopleError: e.toString()));
    }
  }
}
