class TicketModel {
  String menuId;
  String time;
  String course;
  String price;

  TicketModel({
    required this.menuId,
    required this.time,
    required this.course,
    required this.price,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      menuId: json['menuId'] as String,
      time: json['time'] as String,
      course: json['course'] as String,
      price: json['price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'time': time,
      'course': course,
      'price': price,
    };
  }
}
