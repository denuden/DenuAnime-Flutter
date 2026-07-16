import 'package:denuanime/features/common/entities/base_image_model.dart';

class ImageTypeModel {
  final BaseImagesModel? jpg;
  final BaseImagesModel? webp;

  const ImageTypeModel({this.jpg, this.webp});

  factory ImageTypeModel.fromJson(Map<String, dynamic> json) {
    return ImageTypeModel(
      jpg: json['jpg'] != null
          ? BaseImagesModel.fromJson(json['jpg'] as Map<String, dynamic>)
          : null,
      webp: json['webp'] != null
          ? BaseImagesModel.fromJson(json['webp'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'jpg': jpg?.toJson(), 'webp': webp?.toJson()};
  }
}
