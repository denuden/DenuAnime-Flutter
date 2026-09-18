import 'package:denuanime/features/character/domain/entities/character_full_model.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/utils/core/async_value.dart';

class CharacterState {
  final Async<CharacterFullModel> character;
  final Async<PeopleModel> selectedVoiceActor;
  final int selectedVoiceIndex;

  const CharacterState({
    this.character = const AsyncIdle(),
    this.selectedVoiceActor = const AsyncIdle(),
    this.selectedVoiceIndex = -1,
  });

  CharacterState copyWith({
    Async<CharacterFullModel>? character,
    Async<PeopleModel>? selectedVoiceActor,
    int? selectedVoiceIndex,
  }) {
    return CharacterState(
      character: character ?? this.character,
      selectedVoiceActor: selectedVoiceActor ?? this.selectedVoiceActor,
      selectedVoiceIndex: selectedVoiceIndex ?? this.selectedVoiceIndex,
    );
  }
}
