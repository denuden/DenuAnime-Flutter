class StreamingModel {
  final String? name;
  final String? url;

  const StreamingModel({this.name, this.url});

  factory StreamingModel.fromJson(Map<String, dynamic> json) {
    return StreamingModel(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
