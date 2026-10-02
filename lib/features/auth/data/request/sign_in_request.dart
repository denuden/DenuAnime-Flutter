class SignInRequest {
  final String email;
  final String password;

  SignInRequest({required this.email, required this.password});

  SignInRequest copyWith({String? email, String? password}) {
    return SignInRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
