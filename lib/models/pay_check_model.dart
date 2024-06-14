class PayCheckModel {
  String paymentId;
  int courseId;
  String timing;
  String courseType;
  DateTime accountDate;
  String status;
  int price;

  PayCheckModel({
    required this.paymentId,
    required this.courseId,
    required this.timing,
    required this.courseType,
    required this.accountDate,
    required this.status,
    required this.price,
  });

  // fromJson 메서드
  factory PayCheckModel.fromJson(Map<String, dynamic> json) {
    return PayCheckModel(
      paymentId: json['paymentId'],
      courseId: json['courseId'],
      timing: json['timing'],
      courseType: json['courseType'],
      accountDate: DateTime.parse(json['accountDate']),
      status: json['status'],
      price: json['price'],
    );
  }

  // toJson 메서드 (추가)
  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'courseId': courseId,
      'timing': timing,
      'courseType': courseType,
      'accountDate': accountDate.toIso8601String(),
      'status': status,
      'price': price,
    };
  }
}
