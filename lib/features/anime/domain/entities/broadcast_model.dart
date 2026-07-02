class BroadcastModel {
  final String? day;
  final String? time;
  final String? timezone;
  final String? string;

  const BroadcastModel({this.day, this.time, this.timezone, this.string});

  factory BroadcastModel.fromJson(Map<String, dynamic> json) {
    return BroadcastModel(
      day: json['day'] as String?,
      time: json['time'] as String?,
      timezone: json['timezone'] as String?,
      string: json['string'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'day': day,
    'time': time,
    'timezone': timezone,
    'string': string,
  };
}
