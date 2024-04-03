import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/breakpoints.dart';
import 'package:front_have_a_meal/features/student/Ticket/widgets/ticket_time.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';

class StudentTicket extends StatefulWidget {
  const StudentTicket({super.key});

  @override
  State<StudentTicket> createState() => _StudentTicketState();
}

class _StudentTicketState extends State<StudentTicket> {
  Map<String, Map<String, List<TicketModel>>> _ticketMap = {
    "조식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
    "중식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
    "석식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
  };

  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _oninitTicket();
  }

  Future<void> _oninitTicket() async {
    setState(() {
      _isFirstLoading = true;
    });

    _ticketMap["조식"]!["A코스"]!.add(
        TicketModel(menuId: "1", time: "조식", course: "A코스", price: "5000"));
    _ticketMap["조식"]!["B코스"]!.add(
        TicketModel(menuId: "1", time: "조식", course: "B코스", price: "5000"));
    _ticketMap["중식"]!["B코스"]!.add(
        TicketModel(menuId: "1", time: "중식", course: "B코스", price: "5000"));
    _ticketMap["중식"]!["C코스"]!.add(
        TicketModel(menuId: "1", time: "중식", course: "C코스", price: "5000"));
    _ticketMap["석식"]!["A코스"]!.add(
        TicketModel(menuId: "1", time: "석식", course: "A코스", price: "5000"));

    setState(() {
      _isFirstLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isFirstLoading = true;
    });

    _ticketMap = {
      "조식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
      "중식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
      "석식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
    };

    _oninitTicket();

    setState(() {
      _isFirstLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("내 티켓"),
        backgroundColor: Colors.orange.shade100,
      ),
      body: _isFirstLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _ticketMap.entries.every((mealEntry) => mealEntry.value.entries
                  .every((courseEntry) => courseEntry.value.isEmpty))
              ? Center(
                  child: IconButton(
                    iconSize: MediaQuery.of(context).size.width / 3,
                    color: Colors.grey.shade400,
                    icon: const Icon(Icons.refresh_outlined),
                    onPressed: _onRefresh,
                  ),
                )
              : RefreshIndicator.adaptive(
                  onRefresh: _onRefresh,
                  child: ListView(
                    children: [
                      if (!_ticketMap["조식"]!
                          .entries
                          .every((courseEntry) => courseEntry.value.isEmpty))
                        TicketTime(
                          ticketTime: "조식",
                          eatTime: "08:00 ~ 09:00",
                          ticketMap: _ticketMap["조식"]!,
                        ),
                      if (!_ticketMap["중식"]!
                          .entries
                          .every((courseEntry) => courseEntry.value.isEmpty))
                        TicketTime(
                          ticketTime: "중식",
                          eatTime: "12:00~13:30",
                          ticketMap: _ticketMap["중식"]!,
                        ),
                      if (!_ticketMap["석식"]!
                          .entries
                          .every((courseEntry) => courseEntry.value.isEmpty))
                        TicketTime(
                          ticketTime: "석식",
                          eatTime: "17:30~18:30",
                          ticketMap: _ticketMap["석식"]!,
                        ),
                    ],
                  ),
                ),
    );
  }
}
