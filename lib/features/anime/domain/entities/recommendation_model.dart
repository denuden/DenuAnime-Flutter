import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/common/entities/user_model.dart';

class RecommendationModel {
  final int? malId;
  final List<AnimeDetailsModel>? entry;
  final String? content;
  final String? date;
  final UserModel? user;

  const RecommendationModel({
    required this.malId,
    required this.entry,
    required this.content,
    required this.date,
    required this.user,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      malId: json['mal_id'],
      entry: (json['entry'] as List?)
          ?.map((e) => AnimeDetailsModel.fromJson(e))
          .toList(),
      content: json['content'],
      date: json['date'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'entry': entry?.map((e) => e.toJson()).toList(),
      'content': content,
      'date': date,
      'user': user?.toJson(),
    };
  }
}
