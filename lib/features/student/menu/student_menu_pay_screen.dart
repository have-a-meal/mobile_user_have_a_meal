import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StudentMenuPayScreenArgs {
  StudentMenuPayScreenArgs({
    required this.course,
    required this.price,
    required this.time,
  });

  final String time;
  final String course;
  final String price;
}

class StudentMenuPayScreen extends StatelessWidget {
  static const routeName = "student_menu_pay";
  static const routeURL = "student_menu_pay";
  StudentMenuPayScreen({
    super.key,
    required this.time,
    required this.course,
    required this.price,
  });

  final String time;
  final String course;
  final String price;

  final DateTime now = DateTime.now();

  // 티켓 결제 함수
  Future<void> _onTicketPay(BuildContext context) async {
    swagPlatformDialog(
      context: context,
      title: "결제",
      message: "$time $course를 결제하시겠습니까?",
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("취소"),
        ),
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("확인"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // 현재 시간으로부터 14일 뒤의 날짜를 구하되, 자정으로 설정
    final DateTime inFourteenDays = DateTime(now.year, now.month, now.day + 13);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("결제"),
        backgroundColor: Colors.orange.shade100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // 둥근 모서리
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange.shade200,
                        width: 6,
                      ),
                      borderRadius: BorderRadius.circular(20), // 여기도 둥근 모서리를 적용
                      color: Colors.white, // 배경색 지정
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "시간 : $time",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "코스 : $course",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "가격 : $price원",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "유효 기간 : ${DateFormat('yyyy-MM-dd').format(inFourteenDays)} 까지",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange, // Text color
                      minimumSize: const Size.fromHeight(50), // Button size
                      maximumSize: const Size.fromHeight(60), // Button size
                    ),
                    onPressed: () => _onTicketPay(context),
                    child: const Text(
                      '결제하기',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
