class RegisterRequest {
  final String email;
  final String name;
  final String password;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
  });
}
