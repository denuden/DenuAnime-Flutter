import 'package:denuanime/features/common/entities/image_type_model.dart';

class GetPicturesResponse {
  final List<ImageTypeModel>? data;

  const GetPicturesResponse({this.data});

  factory GetPicturesResponse.fromJson(Map<String, dynamic> json) {
    return GetPicturesResponse(
      data: (json['data'] as List?)
          ?.map((e) => ImageTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
