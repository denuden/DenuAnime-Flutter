import 'package:denuanime/features/people/domain/entities/person_model.dart';

class VoiceActorModel {
  final PersonModel? person;
  final String? language;

  VoiceActorModel({this.person, this.language});

  factory VoiceActorModel.fromJson(Map<String, dynamic> json) {
    return VoiceActorModel(
      person: json['person'] != null
          ? PersonModel.fromJson(json['person'] as Map<String, dynamic>)
          : null,
      language: json['language'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'person': person?.toJson(), 'language': language};
  }
}
