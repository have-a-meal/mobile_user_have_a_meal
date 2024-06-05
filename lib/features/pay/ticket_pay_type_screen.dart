import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/pay/enums/ticket_type_enum.dart';
import 'package:front_have_a_meal/features/pay/ticket_pay_screen.dart';
import 'package:go_router/go_router.dart';

class TicketPayTypeScreenArgs {
  final TicketTimeEnum ticketTime;
  final TicketCourseEnum ticketCourse;
  final int ticketPrice;

  TicketPayTypeScreenArgs({
    required this.ticketTime,
    required this.ticketCourse,
    required this.ticketPrice,
  });
}

class TicketPayTypeScreen extends StatelessWidget {
  static const routeName = "ticket_pay_type";
  static const routeURL = "ticket_pay_type";
  const TicketPayTypeScreen({
    super.key,
    required this.ticketTime,
    required this.ticketCourse,
    required this.ticketPrice,
  });

  final TicketTimeEnum ticketTime;
  final TicketCourseEnum ticketCourse;
  final int ticketPrice;

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
                TicketPayScreen.routeName,
                extra: TicketPayScreenArgs(
                  ticketTime: ticketTime,
                  ticketCourse: ticketCourse,
                  ticketPrice: ticketPrice,
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
                TicketPayScreen.routeName,
                extra: TicketPayScreenArgs(
                  ticketTime: ticketTime,
                  ticketCourse: ticketCourse,
                  ticketPrice: ticketPrice,
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
