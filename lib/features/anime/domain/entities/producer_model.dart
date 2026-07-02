class ProducerModel {
  final int? malId;
  final String? type;
  final String? name;
  final String? url;

  const ProducerModel({this.malId, this.type, this.name, this.url});

  factory ProducerModel.fromJson(Map<String, dynamic> json) {
    return ProducerModel(
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
