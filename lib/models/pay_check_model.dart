class PayCheckModel {
  String payId;
  String payType;
  String payCourse;
  int payPrice;
  DateTime payDate;

  PayCheckModel({
    required this.payId,
    required this.payType,
    required this.payCourse,
    required this.payPrice,
    required this.payDate,
  });

  factory PayCheckModel.fromJson(Map<String, dynamic> json) {
    return PayCheckModel(
      payId: json['payId'] as String,
      payType: json['payType'] as String,
      payCourse: json['payCourse'] as String,
      payPrice: json['payPrice'] as int,
      payDate: json['payPrice'] as DateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payId': payId,
      'payType': payType,
      'payCourse': payCourse,
      'payPrice': payPrice,
      'payDate': payDate,
    };
  }
}
