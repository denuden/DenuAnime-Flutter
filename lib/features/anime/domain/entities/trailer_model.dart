import 'package:denuanime/features/common/entities/base_image_model.dart';

class TrailerModel {
  final String? youtube_id;
  final String? url;
  final String? embed_url;
  final BaseImagesModel? images;

  const TrailerModel({this.youtube_id, this.url, this.embed_url, this.images});

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      youtube_id: json['youtube_id'] as String?,
      url: json['url'] as String?,
      embed_url: json['embed_url'] as String?,
      images: json['images'] != null
          ? BaseImagesModel.fromJson(json['images'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'youtube_id': youtube_id,
    'url': url,
    'embed_url': embed_url,
    'images': images?.toJson(),
  };
}
