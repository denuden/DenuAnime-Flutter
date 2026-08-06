import 'package:denuanime/features/character/domain/entities/character_full_model.dart';

class GetCharacterDetailsResponse {
  final CharacterFullModel? data;

  const GetCharacterDetailsResponse({this.data});

  factory GetCharacterDetailsResponse.fromJson(Map<String, dynamic> json) {
    return GetCharacterDetailsResponse(
      data: json['data'] != null
          ? CharacterFullModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
