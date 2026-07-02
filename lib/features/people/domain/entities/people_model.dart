import 'package:denuanime/features/common/entities/image_type_model.dart';
import 'package:denuanime/features/people/domain/entities/people_anime_model.dart';
import 'package:denuanime/features/people/domain/entities/voices_model.dart';

class PeopleModel {
  final int? malId;
  final String? url;
  final String? websiteUrl;
  final ImageTypeModel? images;
  final String? name;
  final String? givenName;
  final String? familyName;
  final List<String?>? alternateNames;
  final String? birthday;
  final int? favorites;
  final String? about;
  final List<PeopleAnimeModel>? anime;
  final List<PeopleAnimeModel>? manga;
  final List<VoicesModel>? voices;

  const PeopleModel({
    this.malId,
    this.url,
    this.websiteUrl,
    this.images,
    this.name,
    this.givenName,
    this.familyName,
    this.alternateNames,
    this.birthday,
    this.favorites,
    this.about,
    this.anime,
    this.manga,
    this.voices,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      malId: json['mal_id'] as int?,
      url: json['url'] as String?,
      websiteUrl: json['website_url'] as String?,
      images: json['images'] != null
          ? ImageTypeModel.fromJson(json['images'])
          : null,
      name: json['name'] as String?,
      givenName: json['given_name'] as String?,
      familyName: json['family_name'] as String?,
      alternateNames: (json['alternate_names'] as List?)
          ?.map((e) => e as String?)
          .toList(),
      birthday: json['birthday'] as String?,
      favorites: json['favorites'] as int?,
      about: json['about'] as String?,
      anime: (json['anime'] as List?)
          ?.map((e) => PeopleAnimeModel.fromJson(e))
          .toList(),
      manga: (json['manga'] as List?)
          ?.map((e) => PeopleAnimeModel.fromJson(e))
          .toList(),
      voices: (json['voices'] as List?)
          ?.map((e) => VoicesModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'url': url,
      'website_url': websiteUrl,
      'images': images?.toJson(),
      'name': name,
      'given_name': givenName,
      'family_name': familyName,
      'alternate_names': alternateNames,
      'birthday': birthday,
      'favorites': favorites,
      'about': about,
      'anime': anime?.map((e) => e.toJson()).toList(),
      'manga': manga?.map((e) => e.toJson()).toList(),
      'voices': voices?.map((e) => e.toJson()).toList(),
    };
  }
}
