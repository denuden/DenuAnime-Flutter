import 'package:denuanime/features/anime/domain/entities/voice_actor_model.dart';
import 'package:denuanime/features/character/domain/cubits/character_state.dart';
import 'package:denuanime/features/character/domain/repositories/character_repo.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepo characterRepo;
  final PeopleRepo peopleRepo;

  CharacterCubit({required this.characterRepo, required this.peopleRepo})
    : super(CharacterState());

  Future<void> loadCharacter(int id) async {
    emit(
      state.copyWith(
        isCharacterDetailsLoading: true,
        characterDetailsError: "",
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

      PeopleModel? selectedVoiceActor;
      if (voices.isNotEmpty) {
        selectedVoiceActor = await peopleRepo.getPeopleDetails(
          voices.first.person?.mal_id ?? 0,
        );
      }

      emit(
        state.copyWith(
          characterDetails: character,
          selectedVoiceActor: selectedVoiceActor,
          selectedVoiceIndex: 0,
          isCharacterDetailsLoading: false,
          characterDetailsError: "",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isCharacterDetailsLoading: false,
          characterDetailsError: e.toString(),
        ),
      );
    }
  }

  Future<void> selectVoiceActor(int index) async {
    try {
      emit(state.copyWith(isPeopleLoading: true));
      final voice = state.characterDetails.voices![index];

      final person = await peopleRepo.getPeopleDetails(
        voice.person?.mal_id ?? 0,
      );

      emit(
        state.copyWith(
          selectedVoiceActor: person,
          selectedVoiceIndex: index,
          isPeopleLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          characterDetailsError: e.toString(),
          isPeopleLoading: false,
        ),
      );
    }
  }
}
