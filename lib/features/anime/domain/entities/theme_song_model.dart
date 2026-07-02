class ThemeSongModel {
  final List<String?>? openings;
  final List<String?>? endings;

  const ThemeSongModel({this.openings, this.endings});

  factory ThemeSongModel.fromJson(Map<String, dynamic> json) {
    return ThemeSongModel(
      openings: (json['openings'] as List?)?.map((e) => e as String?).toList(),
      endings: (json['endings'] as List?)?.map((e) => e as String?).toList(),
    );
  }

  Map<String, dynamic> toJson() => {'openings': openings, 'endings': endings};
}
