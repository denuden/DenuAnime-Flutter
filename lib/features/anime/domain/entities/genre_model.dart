class GenreModel {
  final int? mal_id;
  final String? type;
  final String? name;
  final int? count;
  final String? url;
  final bool is_selected;

  const GenreModel({
    this.mal_id,
    this.type,
    this.name,
    this.count,
    this.url,
    this.is_selected = false,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      mal_id: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': mal_id,
      'type': type,
      'name': name,
      'count': count,
      'url': url,
      'isSelected': is_selected,
    };
  }
}
