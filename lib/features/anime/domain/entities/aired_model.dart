import 'package:denuanime/features/anime/domain/entities/prop_model.dart';

class AiredModel {
  final String? from;
  final String? to;
  final PropModel? prop;
  final String? string;

  const AiredModel({this.from, this.to, this.prop, this.string});

  factory AiredModel.fromJson(Map<String, dynamic> json) {
    return AiredModel(
      from: json['from'] as String?,
      to: json['to'] as String?,
      prop: json['prop'] != null
          ? PropModel.fromJson(json['prop'] as Map<String, dynamic>)
          : null,
      string: json['string'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'from': from,
    'to': to,
    'prop': prop?.toJson(),
    'string': string,
  };
}
