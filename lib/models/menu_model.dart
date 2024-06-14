class MenuModel {
  String timing;
  String courseType;
  String main;
  List<String> sub;

  MenuModel({
    required this.timing,
    required this.courseType,
    required this.main,
    required this.sub,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      timing: json['timing'],
      courseType: json['courseType'],
      main: json['main'],
      sub: List<String>.from(json['sub']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timing': timing,
      'courseType': courseType,
      'main': main,
      'sub': sub,
    };
  }
}
