import 'package:denuanime/features/common/entities/image_type_model.dart';

class PersonModel {
  final int? mal_id;
  final String? url;
  final ImageTypeModel? images;
  final String? name;

  PersonModel({this.mal_id, this.url, this.images, this.name});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      mal_id: json['malId'] as int?,
      url: json['url'] as String?,
      images: json['images'] != null
          ? ImageTypeModel.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': mal_id,
      'url': url,
      'images': images?.toJson(),
      'name': name,
    };
  }
}
