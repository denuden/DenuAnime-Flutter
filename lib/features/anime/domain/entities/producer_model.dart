import 'package:denuanime/features/anime/domain/entities/title_model.dart';
import 'package:denuanime/features/common/entities/image_type_model.dart';

class ProducerModel {
  final int? mal_id;
  final String? type;
  final String? name;
  final String? url;
  final List<TitleModel>? titles;
  final ImageTypeModel? images;
  final int? favorites;
  final String? established;
  final String? about;
  final int? count;
  bool isSelected = false;

  ProducerModel({
    this.mal_id,
    this.type,
    this.name,
    this.url,
    this.titles,
    this.images,
    this.favorites,
    this.established,
    this.about,
    this.count,
    this.isSelected = false,
  });

  factory ProducerModel.fromJson(Map<String, dynamic> json) {
    return ProducerModel(
      mal_id: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      titles: (json['titles'] as List?)
          ?.map((e) => TitleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: json['images'] != null
          ? ImageTypeModel.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      favorites: json['favorites'] as int?,
      established: json['established'] as String?,
      about: json['about'] as String?,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': mal_id,
      'type': type,
      'name': name,
      'url': url,
      'titles': titles?.map((e) => e.toJson()).toList(),
      'images': images?.toJson(),
      'favorites': favorites,
      'established': established,
      'about': about,
      'count': count,
    };
  }
}
