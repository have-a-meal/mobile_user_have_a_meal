class MenuModel {
  String menuId;
  String menuTitle;
  String menuContent;
  String menuPrice;

  MenuModel({
    required this.menuId,
    required this.menuTitle,
    required this.menuContent,
    required this.menuPrice,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      menuId: json['menuId'] as String,
      menuTitle: json['menuTitle'] as String,
      menuContent: json['menuContent'] as String,
      menuPrice: json['menuPrice'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'menuTitle': menuTitle,
      'menuContent': menuContent,
      'menuPrice': menuPrice,
    };
  }
}
