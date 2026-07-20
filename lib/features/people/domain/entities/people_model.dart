import 'package:denuanime/features/common/entities/image_type_model.dart';
import 'package:denuanime/features/people/domain/entities/people_anime_model.dart';
import 'package:denuanime/features/people/domain/entities/voices_model.dart';

class PeopleModel {
  final int? mal_id;
  final String? url;
  final String? website_url;
  final ImageTypeModel? images;
  final String? name;
  final String? given_name;
  final String? family_name;
  final List<String?>? alternate_names;
  final String? birthday;
  final int? favorites;
  final String? about;
  final List<PeopleAnimeModel>? anime;
  final List<PeopleAnimeModel>? manga;
  final List<VoicesModel>? voices;

  const PeopleModel({
    this.mal_id,
    this.url,
    this.website_url,
    this.images,
    this.name,
    this.given_name,
    this.family_name,
    this.alternate_names,
    this.birthday,
    this.favorites,
    this.about,
    this.anime,
    this.manga,
    this.voices,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      mal_id: json['mal_id'] as int?,
      url: json['url'] as String?,
      website_url: json['website_url'] as String?,
      images: json['images'] != null
          ? ImageTypeModel.fromJson(json['images'] as Map<String, dynamic>)
          : null,
      name: json['name'] as String?,
      given_name: json['given_name'] as String?,
      family_name: json['family_name'] as String?,
      alternate_names: (json['alternate_names'] as List?)
          ?.map((e) => e as String?)
          .toList(),
      birthday: json['birthday'] as String?,
      favorites: json['favorites'] as int?,
      about: json['about'] as String?,
      anime: (json['anime'] as List?)
          ?.map((e) => PeopleAnimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      manga: (json['manga'] as List?)
          ?.map((e) => PeopleAnimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      voices: (json['voices'] as List?)
          ?.map((e) => VoicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': mal_id,
      'url': url,
      'website_url': website_url,
      'images': images?.toJson(),
      'name': name,
      'given_name': given_name,
      'family_name': family_name,
      'alternate_names': alternate_names,
      'birthday': birthday,
      'favorites': favorites,
      'about': about,
      'anime': anime?.map((e) => e.toJson()).toList(),
      'manga': manga?.map((e) => e.toJson()).toList(),
      'voices': voices?.map((e) => e.toJson()).toList(),
    };
  }
}
