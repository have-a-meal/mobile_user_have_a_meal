import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/student/menu/menu_pay_screen.dart';
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
    return InkWell(
      onTap: () => context.pushNamed(
        MenuPayScreen.routeName,
        extra: MenuPayScreenArgs(
          course: courseName,
          price: menuData.menuPrice,
          time: timeName,
        ),
      ),
      child: Card(
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
          child: Column(
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
        ),
      ),
    );
  }
}
