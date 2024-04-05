import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/student/menu/widgets/menu_course.dart';
import 'package:front_have_a_meal/models/menu_model.dart';

class MenuTime extends StatelessWidget {
  const MenuTime({
    super.key,
    required this.timeName,
    required this.timeColor,
    required this.menuCourse,
    required this.time,
  });

  final String timeName;
  final String time;
  final Color timeColor;
  final Map<String, List<MenuModel>> menuCourse;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        // color: timeColor,
        border: Border.all(
          color: timeColor,
          width: 6,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  timeName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  time,
                ),
              ),
            ],
          ),
          if (menuCourse["A코스"]!.isNotEmpty)
            MenuCourse(
              timeName: timeName,
              courseName: "A코스",
              courseColor: Colors.lightGreen,
              menuList: menuCourse["A코스"]!,
            ),
          if (menuCourse["B코스"]!.isNotEmpty)
            MenuCourse(
              timeName: timeName,
              courseName: "B코스",
              courseColor: Colors.lightBlue,
              menuList: menuCourse["B코스"]!,
            ),
          if (menuCourse["C코스"]!.isNotEmpty)
            MenuCourse(
              timeName: timeName,
              courseName: "C코스",
              courseColor: Colors.purple,
              menuList: menuCourse["C코스"]!,
            ),
        ],
      ),
    );
  }
}
