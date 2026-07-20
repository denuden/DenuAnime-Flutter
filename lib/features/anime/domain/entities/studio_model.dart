class StudioModel {
  final int? mal_id;
  final String? type;
  final String? name;
  final String? url;

  const StudioModel({this.mal_id, this.type, this.name, this.url});

  factory StudioModel.fromJson(Map<String, dynamic> json) {
    return StudioModel(
      mal_id: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'mal_id': mal_id, 'type': type, 'name': name, 'url': url};
  }
}
