import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_have_a_meal/features/student/pay/student_ticket_pay_screen.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class StudentTicketPayTypeScreenArgs {
  final String menuTime;
  final String menuCourse;
  final int menuPrice;

  StudentTicketPayTypeScreenArgs({
    required this.menuTime,
    required this.menuCourse,
    required this.menuPrice,
  });
}

class StudentTicketPayTypeScreen extends StatelessWidget {
  static const routeName = "student_ticket_pay_type";
  static const routeURL = "student_ticket_pay_type";
  const StudentTicketPayTypeScreen({
    super.key,
    required this.menuTime,
    required this.menuCourse,
    required this.menuPrice,
  });

  final String menuTime;
  final String menuCourse;
  final int menuPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("결제 방식 선택"),
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 3,
        ),
        children: [
          InkWell(
            onTap: () {
              context.pushNamed(
                StudentTicketPayScreen.routeName,
                extra: StudentTicketPayScreenArgs(
                  menuTime: menuTime,
                  menuCourse: menuCourse,
                  menuPrice: menuPrice,
                  payType: "kakaopay",
                ),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.credit_card),
                  Expanded(
                    child: Image.asset(
                        "assets/images/payment_icon_yellow_small.png"),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "카카오페이",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.pushNamed(
                StudentTicketPayScreen.routeName,
                extra: StudentTicketPayScreenArgs(
                  menuTime: menuTime,
                  menuCourse: menuCourse,
                  menuPrice: menuPrice,
                  payType: "tosspay",
                ),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.credit_card),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset("assets/images/logo-toss-pay.png"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "토스페이",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
