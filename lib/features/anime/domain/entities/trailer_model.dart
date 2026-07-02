import 'package:denuanime/features/common/entities/base_image_model.dart';

class TrailerModel {
  final String? youtubeId;
  final String? url;
  final String? embedUrl;
  final BaseImagesModel? images;

  const TrailerModel({this.youtubeId, this.url, this.embedUrl, this.images});

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      youtubeId: json['youtube_id'] as String?,
      url: json['url'] as String?,
      embedUrl: json['embed_url'] as String?,
      images: json['images'] != null
          ? BaseImagesModel.fromJson(json['images'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'youtube_id': youtubeId,
    'url': url,
    'embed_url': embedUrl,
    'images': images?.toJson(),
  };
}
