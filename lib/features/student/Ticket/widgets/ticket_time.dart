import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/student/ticket/widgets/ticket_course.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:gap/gap.dart';

class TicketTime extends StatelessWidget {
  const TicketTime({
    super.key,
    required this.ticketTime,
    required this.ticketMap,
    required this.eatTime,
  });

  final String ticketTime;
  final String eatTime;
  final Map<String, List<TicketModel>> ticketMap;

  int _countNonEmptyCourses(Map<String, List<TicketModel>> courses) {
    int count = 0;
    // courses Map을 순회하면서 각 코스의 리스트가 비어있는지 확인합니다.
    courses.forEach((key, value) {
      if (value.isNotEmpty) {
        // 리스트가 비어있지 않다면, 카운트를 1 증가시킵니다.
        count++;
      }
    });
    if (count <= 1) {
      return 2;
    } else {
      return count;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "[$ticketTime]",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              eatTime,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // 한 줄당 몇개를 넣을건지 지정
            crossAxisCount: 2,
            // 좌우 간격
            crossAxisSpacing: 24,
            // 위아래 간격
            mainAxisSpacing: 24,
            // 한 블럭당 비율 지정 (가로 / 세로)
            childAspectRatio: 1 / 1,
          ),
          children: [
            if (ticketMap["A코스"]!.isNotEmpty)
              TicketCourse(
                ticketTime: ticketTime,
                ticketCourse: "A코스",
                ticketList: ticketMap["A코스"]!,
              ),
            if (ticketMap["B코스"]!.isNotEmpty)
              TicketCourse(
                ticketTime: ticketTime,
                ticketCourse: "B코스",
                ticketList: ticketMap["B코스"]!,
              ),
            if (ticketMap["C코스"]!.isNotEmpty)
              TicketCourse(
                ticketTime: ticketTime,
                ticketCourse: "C코스",
                ticketList: ticketMap["C코스"]!,
              ),
          ],
        ),
      ],
    );
  }
}
