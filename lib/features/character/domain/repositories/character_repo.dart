import 'package:denuanime/features/character/domain/entities/character_full_model.dart';

abstract class CharacterRepo {
  Future<CharacterFullModel> getCharacterDetails(int id);
}
