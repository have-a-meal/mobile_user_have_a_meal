class MenuModel {
  String menuId;
  String title;
  String content;
  String price;

  MenuModel({
    required this.menuId,
    required this.title,
    required this.content,
    required this.price,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      menuId: json['menuId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      price: json['price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'title': title,
      'content': content,
      'price': price,
    };
  }
}
