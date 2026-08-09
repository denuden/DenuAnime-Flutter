import 'dart:io';

import 'package:denuanime/features/character/data/datasource/character_api_datasource.dart';
import 'package:denuanime/features/character/domain/entities/character_full_model.dart';
import 'package:denuanime/features/character/domain/repositories/character_repo.dart';

class CharacterApiRepoImpl implements CharacterRepo {
  final CharacterApiDatasource api;

  CharacterApiRepoImpl(this.api);

  @override
  Future<CharacterFullModel> getCharacterDetails(int id) async {
    final response = await api.getCharacterDetails(id);

    if (response.data != null) {
      return response.data ?? const CharacterFullModel();
    } else {
      throw HttpException("Cannot find character with id of $id");
    }
  }
}
