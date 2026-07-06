class EpisodeModel {
  final int? malId;
  final String? url;
  final String? title;
  final bool? premium;

  const EpisodeModel({
    required this.malId,
    required this.url,
    required this.title,
    required this.premium,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      malId: json['mal_id'] as int?,
      url: json['url'] as String?,
      title: json['title'] as String?,
      premium: json['premium'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'mal_id': malId, 'url': url, 'title': title, 'premium': premium};
  }
}
