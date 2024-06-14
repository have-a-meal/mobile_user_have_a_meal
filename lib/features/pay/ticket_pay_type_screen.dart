import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/features/pay/enums/ticket_type_enum.dart';
import 'package:front_have_a_meal/features/pay/ticket_pay_screen.dart';
import 'package:front_have_a_meal/providers/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TicketPayTypeScreenArgs {
  final TicketTimeEnum ticketTime;
  final TicketCourseEnum ticketCourse;
  final int ticketPrice;
  final int courseId;

  TicketPayTypeScreenArgs({
    required this.ticketTime,
    required this.ticketCourse,
    required this.ticketPrice,
    required this.courseId,
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
    required this.courseId,
  });

  final TicketTimeEnum ticketTime;
  final TicketCourseEnum ticketCourse;
  final int ticketPrice;
  final int courseId;

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
            onTap: () async {
              final url = Uri.parse("${HttpIp.apiUrl}/payment");
              final headers = {'Content-Type': 'application/json'};
              final data = {
                "memberId": context.read<UserProvider>().userData!.memberId,
                "courseId": courseId,
                "pgProvider": "kakaopay",
                "payMethod": "kakaopay"
              };
              final response = await http.post(url,
                  headers: headers, body: jsonEncode(data));

              if (response.statusCode >= 200 && response.statusCode < 300) {
                final jsonResponse = jsonDecode(response.body);
                print(jsonResponse);

                context.pushNamed(
                  TicketPayScreen.routeName,
                  extra: TicketPayScreenArgs(
                    ticketTime: ticketTime,
                    ticketCourse: ticketCourse,
                    ticketPrice: ticketPrice,
                    payType: "kakaopay",
                    paymentId: jsonResponse['paymentId'],
                  ),
                );
              } else {
                HttpIp.errorPrint(
                  context: context,
                  title: "통신 오류",
                  message: response.body,
                );
              }
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
            onTap: () async {
              final url = Uri.parse("${HttpIp.apiUrl}/payment");
              final headers = {'Content-Type': 'application/json'};
              final data = {
                "memberId": context.read<UserProvider>().userData!.memberId,
                "courseId": courseId,
                "pgProvider": "tosspay",
                "payMethod": "tosspay"
              };
              final response = await http.post(url,
                  headers: headers, body: jsonEncode(data));

              if (response.statusCode >= 200 && response.statusCode < 300) {
                final jsonResponse = jsonDecode(response.body);
                print(jsonResponse);

                context.pushNamed(
                  TicketPayScreen.routeName,
                  extra: TicketPayScreenArgs(
                    ticketTime: ticketTime,
                    ticketCourse: ticketCourse,
                    ticketPrice: ticketPrice,
                    payType: "tosspay",
                    paymentId: jsonResponse['paymentId'],
                  ),
                );
              } else {
                HttpIp.errorPrint(
                  context: context,
                  title: "통신 오류",
                  message: response.body,
                );
              }
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
