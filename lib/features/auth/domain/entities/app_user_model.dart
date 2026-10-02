class AppUserModel {
  final String uid;
  final String? email;
  final String? name;
  final String? photo;
  final bool isEmailVerified;

  const AppUserModel({
    required this.uid,
    this.email,
    this.name,
    this.photo,
    this.isEmailVerified = false,
  });

  // convert app user -> json
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'name': name, 'photo': photo};
  }

  // convert json -> app user
  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
    );
  }
}
