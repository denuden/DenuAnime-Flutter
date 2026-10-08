class NoUserException implements Exception {
  final String message;
  NoUserException([this.message = 'No user is signed in']);

  @override
  String toString() {
    return message;
  }
}
