import 'package:denuanime/features/character/data/response/get_character_details_response.dart';
import 'package:dio/dio.dart';

class CharacterApiDatasource {
  final Dio dio;

  CharacterApiDatasource(this.dio);

  Future<GetCharacterDetailsResponse> getCharacterDetails(int id) async {
    final response = await dio.get<Map<String, dynamic>>(
      "/characters/$id/full",
    );

    return GetCharacterDetailsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
