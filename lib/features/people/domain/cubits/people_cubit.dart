import 'dart:io';

import 'package:denuanime/features/people/data/request/search_people_request.dart';
import 'package:denuanime/features/people/domain/cubits/people_state.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final PeopleRepo peopleRepo;

  PeopleCubit({required this.peopleRepo}) : super(const PeopleState());

  //* ================== search
  Future<void> searchPeople(SearchPeopleRequest request) async {
    emit(state.copyWith(people: const AsyncLoading()));

    try {
      final result = await peopleRepo.searchPeople(request);
      if (isClosed) return;
      emit(state.copyWith(people: AsyncData(result)));
    } on HttpException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(people: AsyncFailure(e.message)));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(people: AsyncFailure(e.toString())));
    }
  }

  //* ================== details
  Future<void> getPeopleDetails(int id) async {
    emit(state.copyWith(personDetails: const AsyncLoading()));

    try {
      final result = await peopleRepo.getPeopleDetails(id);
      if (isClosed) return;
      emit(state.copyWith(personDetails: AsyncData(result)));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(personDetails: AsyncFailure(e.toString())));
    }
  }

  Future<void> getFullPeopleDetails(int id) async {
    emit(
      state.copyWith(
        personDetails: const AsyncLoading(),
        pictures: const AsyncLoading(),
      ),
    );

    try {
      final result = await peopleRepo.getFullPeopleDetails(id);
      if (isClosed) return;
      emit(state.copyWith(personDetails: AsyncData(result)));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          personDetails: AsyncFailure(e.toString()),
          pictures: const AsyncIdle(),
        ),
      );
      return;
    }

    await _loadPictures(id);
  }

  Future<void> _loadPictures(int id) async {
    try {
      final result = await peopleRepo.getPictures(id);
      if (isClosed) return;
      emit(state.copyWith(pictures: AsyncData(result)));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(pictures: AsyncFailure(e.toString())));
    }
  }
}
