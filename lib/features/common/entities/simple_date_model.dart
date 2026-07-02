class SimpleDateModel {
  final int? day;
  final int? month;
  final int? year;

  const SimpleDateModel({this.day, this.month, this.year});

  factory SimpleDateModel.fromJson(Map<String, dynamic> json) {
    return SimpleDateModel(
      day: json['day'] as int?,
      month: json['month'] as int?,
      year: json['year'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'day': day, 'month': month, 'year': year};
  }
}
