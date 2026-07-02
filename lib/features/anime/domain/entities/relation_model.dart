import 'package:denuanime/features/anime/domain/entities/entry_model.dart';

class RelationModel {
  final String? relation;
  final List<EntryModel>? entry;

  const RelationModel({this.relation, this.entry});

  factory RelationModel.fromJson(Map<String, dynamic> json) {
    return RelationModel(
      relation: json['relation'] as String?,
      entry: (json['entry'] as List?)
          ?.map((e) => EntryModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relation': relation,
      'entry': entry?.map((e) => e.toJson()).toList(),
    };
  }
}
