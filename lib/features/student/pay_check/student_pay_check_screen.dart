import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class StudentPayCheckScreen extends StatelessWidget {
  static const routeName = "student_pay_check";
  static const routeURL = "student_pay_check";
  const StudentPayCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("결제 내역"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        itemCount: 10,
        separatorBuilder: (context, index) => const Gap(10),
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index % 3 == 0
                          ? const Text(
                              "A코스",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen,
                              ),
                            )
                          : index % 2 == 0
                              ? const Text(
                                  "B코스",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue,
                                  ),
                                )
                              : const Text(
                                  "C코스",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                      index % 5 == 0
                          ? const Text(
                              "[환불]",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            )
                          : const Text(
                              "[구매]",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                  const Divider(),
                  Text(
                    index % 5 == 0
                        ? "환불날짜 : ${DateFormat('yyyy-MM-dd(E) HH:mm', 'ko_KR').format(DateTime.now())}"
                        : "구매날짜 : ${DateFormat('yyyy-MM-dd(E) HH:mm', 'ko_KR').format(DateTime.now())}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    index % 5 == 0 ? "환불가격 : 5000원" : "구매가격 : 5000원",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
