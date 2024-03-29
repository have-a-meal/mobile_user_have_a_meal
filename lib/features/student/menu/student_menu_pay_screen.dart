import 'package:flutter/material.dart';

class StudentMenuPayScreen extends StatelessWidget {
  static const routeName = "student_menu_pay";
  static const routeURL = "student_menu_pay";
  const StudentMenuPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("결제"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "시간 : 조식/중식/석식",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "코스 : A/B/C 코스",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "가격 : 5000원",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "유효 기간 : 0000-00-00 00:00:00 까지",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
