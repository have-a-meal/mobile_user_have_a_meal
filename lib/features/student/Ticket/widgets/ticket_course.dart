import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/student/ticket/student_qr_screen.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:go_router/go_router.dart';

class TicketCourse extends StatefulWidget {
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
  State<TicketCourse> createState() => _TicketCourseState();
}

class _TicketCourseState extends State<TicketCourse> {
  Color _ticketColor = Colors.orange;

  @override
  void initState() {
    super.initState();

    if (widget.ticketCourse == "A코스") {
      _ticketColor = Colors.lightGreen;
    } else if (widget.ticketCourse == "B코스") {
      _ticketColor = Colors.lightBlue;
    } else if (widget.ticketCourse == "C코스") {
      _ticketColor = Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        StudentQrScreen.routeName,
        extra: StudentQrScreenArgs(
          ticketTime: widget.ticketTime,
          ticketCourse: widget.ticketCourse,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 4,
            color: _ticketColor,
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
                  widget.ticketCourse,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: _ticketColor,
                  ),
                ),
                // const Divider(),
                // Text(
                //   "가격 : ${widget.ticketList[0].ticketPrice}원",
                //   style: const TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${widget.ticketList.length}개",
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
