import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/ticket/qr_use_screen.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:go_router/go_router.dart';

class TicketCourse extends StatelessWidget {
  const TicketCourse({
    super.key,
    required this.ticketCourse,
    required this.ticketList,
    required this.ticketTime,
  });

  final String ticketTime;
  final String ticketCourse;
  final List<TicketModel> ticketList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          QrUseScreen.routeName,
          extra: QrUseScreenArgs(
            ticketTime: ticketTime,
            ticketCourse: ticketCourse,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 4,
            color: ticketCourse == "A"
                ? Colors.lightGreen
                : ticketCourse == "B"
                    ? Colors.lightBlue
                    : Colors.purple,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // 그림자 색상
              spreadRadius: 0, // 그림자의 확장 정도
              blurRadius: 4, // 그림자의 흐림 정도
              offset: const Offset(4, 4), // 오른쪽과 아래쪽으로 그림자 오프셋
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$ticketCourse코스",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: ticketCourse == "A"
                        ? Colors.lightGreen
                        : ticketCourse == "B"
                            ? Colors.lightBlue
                            : Colors.purple,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${ticketList.length}개",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
