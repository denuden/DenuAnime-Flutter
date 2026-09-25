import 'package:denuanime/features/common/entities/image_type_model.dart';

class EntryModel {
  final int? mal_id;
  final String? type;
  final String? name;
  final String? url;
  final String? media_type;
  final ImageTypeModel? images;

  const EntryModel({
    this.mal_id,
    this.type,
    this.name,
    this.url,
    this.media_type,
    this.images,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
      mal_id: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      media_type: json['media_type'] as String?,
      images: json['images'] != null
          ? ImageTypeModel.fromJson(json['images'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': mal_id,
      'type': type,
      'name': name,
      'url': url,
      'media_type': media_type,
      'images': images?.toJson(),
    };
  }
}
