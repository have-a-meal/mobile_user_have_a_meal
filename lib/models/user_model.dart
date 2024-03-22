class UserModel {
  String userId;
  String password;
  String name;

  UserModel({
    required this.userId,
    required this.password,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'password': password,
      'name': name,
    };
  }
}
