import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/common/entities/user_model.dart';

class RecommendationModel {
  final int? mal_id;
  final List<AnimeDetailsModel>? entry;
  final String? content;
  final String? date;
  final UserModel? user;

  const RecommendationModel({
    required this.mal_id,
    required this.entry,
    required this.content,
    required this.date,
    required this.user,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      mal_id: json['mal_id'] as int,
      entry: (json['entry'] as List?)
          ?.map((e) => AnimeDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String,
      date: json['date'] as String,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': mal_id,
      'entry': entry?.map((e) => e.toJson()).toList(),
      'content': content,
      'date': date,
      'user': user?.toJson(),
    };
  }
}
