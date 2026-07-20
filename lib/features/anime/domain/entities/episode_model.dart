class EpisodeModel {
  final int? mal_id;
  final String? url;
  final String? title;
  final bool? premium;

  const EpisodeModel({
    required this.mal_id,
    required this.url,
    required this.title,
    required this.premium,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      mal_id: json['mal_id'] as int?,
      url: json['url'] as String?,
      title: json['title'] as String?,
      premium: json['premium'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'mal_id': mal_id, 'url': url, 'title': title, 'premium': premium};
  }
}
