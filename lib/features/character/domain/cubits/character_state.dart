import 'package:denuanime/features/character/domain/entities/character_full_model.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';

class CharacterState {
  final CharacterFullModel characterDetails;

  final bool isCharacterDetailsLoading;

  final String characterDetailsError;

  final String characterInitial;

  PeopleModel selectedVoiceActor;

  int selectedVoiceIndex;

  final bool isPeopleLoading;

  CharacterState({
    this.characterDetails = const CharacterFullModel(),

    this.isCharacterDetailsLoading = false,

    this.characterDetailsError = "",

    this.characterInitial = "",

    this.selectedVoiceActor = const PeopleModel(),
    this.selectedVoiceIndex = -1,
    this.isPeopleLoading = false,
  });

  CharacterState copyWith({
    CharacterFullModel? characterDetails,

    bool? isCharacterDetailsLoading,

    String? characterDetailsError,

    PeopleModel? selectedVoiceActor,
    int? selectedVoiceIndex,
    bool? isPeopleLoading,
  }) {
    return CharacterState(
      characterDetails: characterDetails ?? this.characterDetails,

      isCharacterDetailsLoading:
          isCharacterDetailsLoading ?? this.isCharacterDetailsLoading,

      characterDetailsError:
          characterDetailsError ?? this.characterDetailsError,
      selectedVoiceActor: selectedVoiceActor ?? this.selectedVoiceActor,
      selectedVoiceIndex: selectedVoiceIndex ?? this.selectedVoiceIndex,
      isPeopleLoading: isPeopleLoading ?? this.isPeopleLoading,
    );
  }
}
