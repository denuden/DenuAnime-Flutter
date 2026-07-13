class UserModel {
  final String? url;
  final String? username;

  const UserModel({required this.url, required this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      url: json['url'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'username': username};
  }
}
