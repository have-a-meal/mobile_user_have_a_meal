import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/features/ticket/widgets/ticket_time.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:front_have_a_meal/providers/ticket_provider.dart';
import 'package:front_have_a_meal/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

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
    });

    // _oninitTicket();
  }

  Future<void> _oninitTicket() async {
    final url = Uri.parse(
        "${HttpIp.apiUrl}/ticket/${context.read<UserProvider>().userData?.memberId}");
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List;
      List<TicketModel> ticketList =
          jsonResponse.map((json) => TicketModel.fromJson(json)).toList();

      if (!mounted) return;
      await context.read<TicketProvider>().addTicket(ticketList);
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류 TicketView",
        message: response.body,
      );
    }

    setState(() {
      _isFirstLoading = false;
    });
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
