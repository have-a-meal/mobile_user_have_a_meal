import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_have_a_meal/features/menu/qr_use_screen.dart';
import 'package:front_have_a_meal/models/menu_model.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.menuData,
    required this.courseName,
    required this.timeName,
  });

  final MenuModel menuData;
  final String courseName;
  final String timeName;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
          border: Border.all(
            width: 2,
            color: courseName == "A코스"
                ? Colors.lightGreen.shade200
                : courseName == "B코스"
                    ? Colors.lightBlue.shade200
                    : Colors.purple.shade200,
          ),
          color: Colors.white, // 배경색
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // 그림자 색상
              spreadRadius: 0, // 그림자의 확장 정도
              blurRadius: 4, // 그림자의 흐림 정도
              offset: const Offset(4, 4), // 오른쪽과 아래쪽으로 그림자 오프셋
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuData.menuTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(4),
                    Text(menuData.menuContent),
                  ],
                ),
                Transform.scale(
                  scale: 2,
                  // 아이콘 위치 조정
                  child: Transform.translate(
                    offset: const Offset(5, 12),
                    child: Icon(
                      Icons.restaurant_menu_outlined,
                      color: courseName == "A코스"
                          ? Colors.lightGreen.shade200
                          : courseName == "B코스"
                              ? Colors.lightBlue.shade200
                              : Colors.purple.shade200,
                      size: 36,
                    ),
                  ),
                )
              ],
            ),
            // const Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Text(
            //     "n개",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 22,
            //       // color: Colors.red,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
