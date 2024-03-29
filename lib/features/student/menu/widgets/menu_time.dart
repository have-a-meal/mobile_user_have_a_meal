import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/student/menu/widgets/menu_course.dart';
import 'package:front_have_a_meal/models/menu_model.dart';
import 'package:gap/gap.dart';

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
        color: timeColor,
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
              courseName: "A코스",
              courseColor: timeName == "조식"
                  ? const Color(0xFF81B29A)
                  : timeName == "중식"
                      ? const Color(0xFFF4A261)
                      : const Color(0xFFE07A5F),
              menuList: menuCourse["A코스"]!,
            ),
          if (menuCourse["B코스"]!.isNotEmpty)
            MenuCourse(
              courseName: "B코스",
              courseColor: timeName == "조식"
                  ? const Color(0xFFE63946)
                  : timeName == "중식"
                      ? const Color(0xFF2A9D8F)
                      : const Color(0xFFF77F00),
              menuList: menuCourse["B코스"]!,
            ),
          if (menuCourse["C코스"]!.isNotEmpty)
            MenuCourse(
              courseName: "C코스",
              courseColor: timeName == "조식"
                  ? const Color(0xFF264653)
                  : timeName == "중식"
                      ? const Color(0xFF7400B8)
                      : const Color(0xFF023E8A),
              menuList: menuCourse["C코스"]!,
            ),
        ],
      ),
    );
  }
}
