class TicketModel {
  String timing;
  String courseType;
  int quantity;

  TicketModel({
    required this.timing,
    required this.courseType,
    required this.quantity,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      timing: json['timing'] as String,
      courseType: json['courseType'] as String,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timing': timing,
      'courseType': courseType,
      'quantity': quantity,
    };
  }
}
