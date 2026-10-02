class AuthFailure implements Exception {
  final String message;
  final String code;

  const AuthFailure(this.message, {this.code = 'unknown'});

  @override
  String toString() {
    return 'AuthFailure($code): $message';
  }
}
