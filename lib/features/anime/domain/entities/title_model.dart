class TitleModel {
  final String? type;
  final String? title;

  const TitleModel({this.type, this.title});

  factory TitleModel.fromJson(Map<String, dynamic> json) {
    return TitleModel(
      type: json['type'] as String?,
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'title': title};
  }
}
