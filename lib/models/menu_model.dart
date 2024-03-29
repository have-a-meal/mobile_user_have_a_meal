class MenuModel {
  String menuId;
  String title;
  String content;

  MenuModel({
    required this.menuId,
    required this.title,
    required this.content,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
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
