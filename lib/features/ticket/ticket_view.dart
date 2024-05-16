import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/ticket/widgets/ticket_time.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:front_have_a_meal/providers/ticket_provider.dart';
import 'package:provider/provider.dart';

class TicketView extends StatefulWidget {
  const TicketView({super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  bool _isFirstLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _oninitTicket();

      _isFirstLoading = false;
    });

    // _oninitTicket();
  }

  Future<void> _oninitTicket() async {
    await context.read<TicketProvider>().addTicket([
      TicketModel(
          ticketId: "1",
          ticketTime: "조식",
          ticketCourse: "A코스",
          ticketPrice: "5000"),
      TicketModel(
          ticketId: "2",
          ticketTime: "조식",
          ticketCourse: "B코스",
          ticketPrice: "5000"),
      TicketModel(
          ticketId: "3",
          ticketTime: "중식",
          ticketCourse: "B코스",
          ticketPrice: "5000"),
      TicketModel(
          ticketId: "4",
          ticketTime: "중식",
          ticketCourse: "C코스",
          ticketPrice: "5000"),
      TicketModel(
          ticketId: "5",
          ticketTime: "석식",
          ticketCourse: "A코스",
          ticketPrice: "5000"),
      TicketModel(
          ticketId: "6",
          ticketTime: "조식",
          ticketCourse: "A코스",
          ticketPrice: "5000"),
      TicketModel(
          ticketId: "7",
          ticketTime: "조식",
          ticketCourse: "A코스",
          ticketPrice: "5000"),
      TicketModel(
          ticketId: "8",
          ticketTime: "조식",
          ticketCourse: "A코스",
          ticketPrice: "5000"),
    ]);
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isFirstLoading = true;
    });

    context.read<TicketProvider>().resetTicket();

    _oninitTicket();

    setState(() {
      _isFirstLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ticketMap = context.watch<TicketProvider>().ticketMap;
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 식권"),
      ),
      body: _isFirstLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ticketMap.entries.every((mealEntry) => mealEntry.value.entries
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
                      if (!ticketMap["조식"]!
                          .entries
                          .every((courseEntry) => courseEntry.value.isEmpty))
                        TicketTime(
                          ticketTime: "조식",
                          eatTime: "08:00 ~ 09:00",
                          ticketMap: ticketMap["조식"]!,
                        ),
                      if (!ticketMap["중식"]!
                          .entries
                          .every((courseEntry) => courseEntry.value.isEmpty))
                        TicketTime(
                          ticketTime: "중식",
                          eatTime: "12:00~13:30",
                          ticketMap: ticketMap["중식"]!,
                        ),
                      if (!ticketMap["석식"]!
                          .entries
                          .every((courseEntry) => courseEntry.value.isEmpty))
                        TicketTime(
                          ticketTime: "석식",
                          eatTime: "17:30~18:30",
                          ticketMap: ticketMap["석식"]!,
                        ),
                    ],
                  ),
                ),
    );
  }
}
