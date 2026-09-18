import 'dart:io';

import 'package:denuanime/features/anime/domain/entities/voice_actor_model.dart';
import 'package:denuanime/features/character/domain/cubits/character_state.dart';
import 'package:denuanime/features/character/domain/entities/character_full_model.dart';
import 'package:denuanime/features/character/domain/repositories/character_repo.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepo characterRepo;
  final PeopleRepo peopleRepo;

  CharacterCubit({required this.characterRepo, required this.peopleRepo})
    : super(const CharacterState());

  Future<void> loadCharacter(int id) async {
    emit(
      state.copyWith(
        character: const AsyncLoading(),
        selectedVoiceActor: const AsyncLoading(),
        selectedVoiceIndex: -1,
      ),
    );
    try {
      var character = await characterRepo.getCharacterDetails(id);

      // Make Japanese VA first
      final voices = List<VoiceActorModel>.from(character.voices ?? []);
      final japaneseIndex = voices.indexWhere(
        (voice) => voice.language == "Japanese",
      );

      if (japaneseIndex != -1) {
        final japanese = voices.removeAt(japaneseIndex);
        voices.insert(0, japanese);
      }

      character = character.copyWith(voices: voices);

      if (isClosed) return;

      //show character still even without voices
      if (voices.isEmpty) {
        emit(
          state.copyWith(
            character: AsyncData(character),
            selectedVoiceActor: const AsyncIdle(),
          ),
        );
        return;
      }

      // show the character while the VA still loads
      emit(
        state.copyWith(character: AsyncData(character), selectedVoiceIndex: 0),
      );

      await _loadVoiceActor(0, voices.first.person?.mal_id ?? 0);
    } on HttpException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(character: AsyncFailure(e.message.toString())));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(character: AsyncFailure(e.toString())));
    }
  }

  Future<void> selectVoiceActor(int index) async {
    final current = state.character;
    if (current is! AsyncData<CharacterFullModel>) return;

    final voices = current.value.voices ?? [];
    if (index < 0 || index >= voices.length) return;

    await _loadVoiceActor(index, voices[index].person?.mal_id ?? 0);
  }

  Future<void> _loadVoiceActor(int index, int personId) async {
    emit(
      state.copyWith(
        selectedVoiceActor: const AsyncLoading(),
        selectedVoiceIndex: index,
      ),
    );

    try {
      final person = await peopleRepo.getPeopleDetails(personId);
      if (isClosed) return;
      emit(state.copyWith(selectedVoiceActor: AsyncData(person)));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(selectedVoiceActor: AsyncFailure(e.toString())));
    }
  }
}
