class UserModel {
  String memberId;
  String phone;
  String name;
  String memberType;

  UserModel({
    required this.memberId,
    required this.phone,
    required this.name,
    required this.memberType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      memberId: json['memberId'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      memberType: json['memberType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'phone': phone,
      'name': name,
      'memberType': memberType,
    };
  }
}
