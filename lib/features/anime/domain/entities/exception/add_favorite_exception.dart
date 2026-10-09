class FavoriteException implements Exception {
  final String message;

  FavoriteException([this.message = "Failed to add favorite"]);

  @override
  String toString() => message;
}
