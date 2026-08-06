import 'package:denuanime/features/people/domain/entities/people_model.dart';

class GetPeopleDetailsResponse {
  final PeopleModel? data;

  const GetPeopleDetailsResponse({this.data});

  factory GetPeopleDetailsResponse.fromJson(Map<String, dynamic> json) {
    return GetPeopleDetailsResponse(
      data: json['data'] != null
          ? PeopleModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
