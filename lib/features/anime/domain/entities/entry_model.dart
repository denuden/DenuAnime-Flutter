class EntryModel {
  final int? malId;
  final String? type;
  final String? name;
  final String? url;

  const EntryModel({this.malId, this.type, this.name, this.url});

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
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
