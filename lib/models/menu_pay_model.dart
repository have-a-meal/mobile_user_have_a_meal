class MenuPayModel {
  String menuId;
  String title;
  String content;
  String price;
  // String time;
  // String course;
  // String price;

  MenuPayModel({
    required this.menuId,
    required this.title,
    required this.content,
    required this.price,
    // required this.time,
    // required this.course,
    // required this.price,
  });

  factory MenuPayModel.fromJson(Map<String, dynamic> json) {
    return MenuPayModel(
      menuId: json['menuId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      price: json['price'] as String,
      // time: json['time'] as String,
      // course: json['course'] as String,
      // price: json['price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'title': title,
      'content': content,
      'price': price,
      // 'time': time,
      // 'course': course,
      // 'price': price,
    };
  }
}
