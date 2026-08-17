import 'package:denuanime/features/common/entities/base_image_model.dart';

class TrailerModel {
  final String? youtube_id;
  final String? url;
  final String? embed_url;
  final String? title;
  final int? views;
  final int? likes;
  final int? dislikes;
  final int? comment_count;
  final String? published_at;
  final String? duration;
  final String? privacy_status;
  final String? region_restrictions;
  final bool? embedabble;
  final BaseImagesModel? images;

  const TrailerModel({
    this.youtube_id,
    this.url,
    this.embed_url,
    this.images,
    this.title,
    this.views,
    this.likes,
    this.dislikes,
    this.comment_count,
    this.published_at,
    this.duration,
    this.privacy_status,
    this.region_restrictions,
    this.embedabble,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      youtube_id: json['youtube_id'] as String?,
      url: json['url'] as String?,
      embed_url: json['embed_url'] as String?,
      images: json['images'] != null
          ? BaseImagesModel.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      title: json['title'] as String?,
      views: json['views'] as int?,
      likes: json['likes'] as int?,
      dislikes: json['dislikes'] as int?,
      comment_count: json['comment_count'] as int?,
      published_at: json['published_at'] as String?,
      duration: json['duration'] as String?,
      privacy_status: json['privacy_status'] as String?,
      region_restrictions: json['region_restrictions'] as String?,
      embedabble: json['embedabble'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'youtube_id': youtube_id,
    'url': url,
    'embed_url': embed_url,
    'images': images?.toJson(),
    'title': title,
    'views': views,
    'likes': likes,
    'dislikes': dislikes,
    'comment_count': comment_count,
    'published_at': published_at,
    'duration': duration,
    'privacy_status': privacy_status,
    'region_restrictions': region_restrictions,
    'embedabble': embedabble,
  };
}
