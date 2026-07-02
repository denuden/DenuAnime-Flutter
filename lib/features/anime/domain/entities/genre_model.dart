class GenreModel {
  final int? malId;
  final String? type;
  final String? name;
  final int? count;
  final String? url;
  final bool isSelected;

  const GenreModel({
    this.malId,
    this.type,
    this.name,
    this.count,
    this.url,
    this.isSelected = false,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      malId: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'type': type,
      'name': name,
      'count': count,
      'url': url,
      'isSelected': isSelected,
    };
  }
}
