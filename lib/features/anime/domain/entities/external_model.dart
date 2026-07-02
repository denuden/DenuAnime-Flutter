class ExternalModel {
  final String? name;
  final String? url;

  const ExternalModel({this.name, this.url});

  factory ExternalModel.fromJson(Map<String, dynamic> json) {
    return ExternalModel(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
