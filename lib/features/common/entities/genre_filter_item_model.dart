class GenreFilterItemModel {
  final int? malId;
  final String? name;
  final String? url;
  final int? count;
  bool isSelected = false;

  GenreFilterItemModel({
    required this.malId,
    required this.name,
    required this.url,
    required this.count,
    this.isSelected = false,
  });
}
