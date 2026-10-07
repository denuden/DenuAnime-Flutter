class RegisterRequest {
  final String email;
  final String name;
  final String password;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
  });

  RegisterRequest copyWith({String? email, String? name, String? password}) {
    return RegisterRequest(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
