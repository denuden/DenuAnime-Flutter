class StudioModel {
  final int? malId;
  final String? type;
  final String? name;
  final String? url;

  const StudioModel({this.malId, this.type, this.name, this.url});

  factory StudioModel.fromJson(Map<String, dynamic> json) {
    return StudioModel(
      malId: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'mal_id': malId, 'type': type, 'name': name, 'url': url};
  }
}
