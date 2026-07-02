import 'package:denuanime/features/common/entities/image_type_model.dart';

class CharacterModel {
  final int? malId;
  final String? url;
  final ImageTypeModel? images;
  final String? name;

  const CharacterModel({this.malId, this.url, this.images, this.name});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      malId: json['mal_id'] as int?,
      url: json['url'] as String?,
      images: json['images'] != null
          ? ImageTypeModel.fromJson(json['images'])
          : null,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'url': url,
      'images': images?.toJson(),
      'name': name,
    };
  }
}
