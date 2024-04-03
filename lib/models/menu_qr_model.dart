class MenuQRModel {
  String menuId;
  String title;
  String content;

  MenuQRModel({
    required this.menuId,
    required this.title,
    required this.content,
  });

  factory MenuQRModel.fromJson(Map<String, dynamic> json) {
    return MenuQRModel(
      menuId: json['menuId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'title': title,
      'content': content,
    };
  }
}
