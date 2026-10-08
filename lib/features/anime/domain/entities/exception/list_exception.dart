class ListException implements Exception {
  static const defaultMessage = "There was an error in fetching your list";

  final String message;

  ListException([String? detail])
    : message = detail == null ? defaultMessage : "$defaultMessage: $detail";

  @override
  String toString() => message;
}
