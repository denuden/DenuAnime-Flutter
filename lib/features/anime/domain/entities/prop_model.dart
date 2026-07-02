import 'package:denuanime/features/common/entities/simple_date_model.dart';

class PropModel {
  final SimpleDateModel? from;
  final SimpleDateModel? to;

  const PropModel({this.from, this.to});

  factory PropModel.fromJson(Map<String, dynamic> json) {
    return PropModel(
      from: json['from'] != null
          ? SimpleDateModel.fromJson(json['from'])
          : null,
      to: json['to'] != null ? SimpleDateModel.fromJson(json['to']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'from': from?.toJson(), 'to': to?.toJson()};
}
