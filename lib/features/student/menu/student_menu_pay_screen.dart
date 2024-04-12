import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/student/pay/student_ticket_pay_screen.dart';
import 'package:front_have_a_meal/features/student/pay/student_ticket_pay_type_screen.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

enum TicketTime {
  breakfast,
  lunch,
  dinner,
}

enum TicketCourse {
  a,
  b,
  c,
}

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

class StudentMenuPayScreen extends StatefulWidget {
  static const routeName = "student_menu_pay";
  static const routeURL = "student_menu_pay";
  const StudentMenuPayScreen({
    super.key,
    required this.time,
    required this.course,
    required this.price,
  });

  final String time;
  final String course;
  final String price;

  @override
  State<StudentMenuPayScreen> createState() => _StudentMenuPayScreenState();
}

class _StudentMenuPayScreenState extends State<StudentMenuPayScreen> {
  TicketTime _ticketTime = TicketTime.breakfast;
  TicketCourse _ticketCourse = TicketCourse.a;

  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.time == "조식") {
      _ticketTime = TicketTime.breakfast;
    } else if (widget.time == "중식") {
      _ticketTime = TicketTime.lunch;
    } else if (widget.time == "석식") {
      _ticketTime = TicketTime.dinner;
    }

    if (widget.course == "A코스") {
      _ticketCourse = TicketCourse.a;
    } else if (widget.course == "B코스") {
      _ticketCourse = TicketCourse.b;
    } else if (widget.course == "C코스") {
      _ticketCourse = TicketCourse.c;
    }
  }

  // 티켓 결제 함수
  Future<void> _onTicketPay(BuildContext context) async {
    swagPlatformDialog(
      context: context,
      title: "결제",
      message: "${widget.time} ${widget.course}를 결제하시겠습니까?",
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("취소"),
        ),
        ElevatedButton(
          onPressed: () {
            context.pushNamed(
              StudentTicketPayTypeScreen.routeName,
              extra: StudentTicketPayTypeScreenArgs(
                menuTime: widget.time,
                menuCourse: widget.course,
                menuPrice: int.parse(widget.price),
              ),
            );
          },
          child: const Text("확인"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("결제"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(20),
          SegmentedButton(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: TicketTime.breakfast,
                label: Text("조식"),
              ),
              ButtonSegment(
                value: TicketTime.lunch,
                label: Text("중식"),
              ),
              ButtonSegment(
                value: TicketTime.dinner,
                label: Text("석식"),
              ),
            ],
            selected: <TicketTime>{_ticketTime},
            onSelectionChanged: (Set<TicketTime> newSelection) {
              setState(() {
                _ticketTime = newSelection.first;
              });
            },
          ),
          const Gap(20),
          SegmentedButton(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: TicketCourse.a,
                label: Text("A코스"),
              ),
              ButtonSegment(
                value: TicketCourse.b,
                label: Text("B코스"),
              ),
              ButtonSegment(
                value: TicketCourse.c,
                label: Text("C코스"),
              ),
            ],
            selected: <TicketCourse>{_ticketCourse},
            onSelectionChanged: (Set<TicketCourse> newSelection) {
              setState(() {
                _ticketCourse = newSelection.first;
              });
            },
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                        "시간 : ${_ticketTime == TicketTime.breakfast ? "조식" : _ticketTime == TicketTime.lunch ? "중식" : "석식"}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "코스 : ${_ticketCourse == TicketCourse.a ? "A코스" : _ticketCourse == TicketCourse.b ? "B코스" : "C코스"}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "가격 : ${widget.price}원",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      const Text(
                        "유효 기간 : 현재 학기",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                const Text(
                  "식권의 유효 기간이 지나면 환급 받을 수 있습니다",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                )
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
