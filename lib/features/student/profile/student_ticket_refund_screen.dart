import 'package:flutter/material.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:front_have_a_meal/providers/ticket_provider.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StudentTicketRefundScreen extends StatefulWidget {
  static const routeName = "student_ticket_refund";
  static const routeURL = "student_ticket_refund";
  const StudentTicketRefundScreen({super.key});

  @override
  State<StudentTicketRefundScreen> createState() =>
      _StudentTicketRefundScreenState();
}

class _StudentTicketRefundScreenState extends State<StudentTicketRefundScreen>
    with TickerProviderStateMixin {
  List<TicketModel> _ticketEnabledList = [];
  List<TicketModel> _ticketDisabledList = [];
  // 선택한 환불 티켓
  Set<TicketModel> _selectedRefundDisabledTicket = {};
  Set<TicketModel> _selectedRefundEnabledTicket = {};

  @override
  void initState() {
    super.initState();

    _onCheckedEnabledTicket();
  }

  Future<void> _onCheckedEnabledTicket() async {
    _ticketEnabledList = [];
    _ticketDisabledList = [];

    for (TicketModel ticket in [
      TicketModel(
        ticketId: "1",
        ticketTime: "조식",
        ticketCourse: "A코스",
        ticketPrice: "5000",
      ),
      TicketModel(
        ticketId: "2",
        ticketTime: "중식",
        ticketCourse: "B코스",
        ticketPrice: "5000",
      ),
      TicketModel(
        ticketId: "3",
        ticketTime: "중식",
        ticketCourse: "C코스",
        ticketPrice: "5000",
      ),
    ]) {
      if (int.parse(ticket.ticketId) % 2 == 0) {
        _ticketEnabledList.add(ticket);
      } else {
        _ticketDisabledList.add(ticket);
      }
    }

    if (_ticketDisabledList.isNotEmpty) {
      _selectedRefundDisabledTicket.add(_ticketDisabledList[0]);
    }
    if (_ticketEnabledList.isNotEmpty) {
      _selectedRefundEnabledTicket.add(_ticketEnabledList[0]);
    }
    if (_ticketEnabledList.isNotEmpty) {
      // _selectedQRTicket = _ticketEnabledList[0].ticketId;
    }

    setState(() {});
  }

  Future<void> _onRefreshTicketList() async {
    _onCheckedEnabledTicket();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _ticketEnabledList.isEmpty ? 1 : 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('식권 환불'),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "사용 가능 [${_ticketEnabledList.length}]개"),
              Tab(text: "기간 만료 [${_ticketDisabledList.length}]개"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ticketEnabledList.isNotEmpty
                ? RefreshIndicator.adaptive(
                    onRefresh: _onRefreshTicketList,
                    child: Column(
                      children: [
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 24,
                                ),
                              ),
                              onPressed: () {
                                if (_selectedRefundEnabledTicket.length ==
                                    _ticketEnabledList.length) {
                                  _selectedRefundEnabledTicket = {};
                                } else {
                                  for (TicketModel ticket
                                      in _ticketEnabledList) {
                                    _selectedRefundEnabledTicket.add(ticket);
                                  }
                                }
                                setState(() {});
                              },
                              child: _selectedRefundEnabledTicket.length ==
                                      _ticketEnabledList.length
                                  ? const Text("전체 해제")
                                  : const Text("전체 선택"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 24,
                                ),
                                backgroundColor: Colors.red,
                              ),
                              onPressed: _selectedRefundEnabledTicket.isNotEmpty
                                  ? () async {
                                      await swagPlatformDialog(
                                        context: context,
                                        title: "환불",
                                        message: "정말 선택한 식권들을 환불 하시겠습니까?",
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: const Text("아니오"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (await context
                                                  .read<TicketProvider>()
                                                  .removeTicket(
                                                      _selectedRefundEnabledTicket)) {
                                                for (TicketModel ticket
                                                    in _selectedRefundEnabledTicket) {
                                                  _ticketEnabledList
                                                      .remove(ticket);
                                                }
                                              }
                                              if (_ticketEnabledList
                                                  .isNotEmpty) {
                                                // _selectedQRTicket =
                                                //     _ticketEnabledList[
                                                //             0]
                                                //         .ticketId;
                                              }
                                              _selectedRefundEnabledTicket = {};
                                              setState(() {});
                                              if (!context.mounted) {
                                                return;
                                              }
                                              context.pop();
                                            },
                                            child: const Text("예"),
                                          ),
                                        ],
                                      );
                                    }
                                  : null,
                              child: const Text(
                                "환불 하기",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _ticketEnabledList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.1,
                                ),
                              ),
                              child: CheckboxListTile.adaptive(
                                value: _selectedRefundEnabledTicket
                                    .contains(_ticketEnabledList[index]),
                                onChanged: (value) {
                                  if (value == null) return;
                                  TicketModel currentTicket =
                                      _ticketEnabledList[index];
                                  if (value) {
                                    _selectedRefundEnabledTicket
                                        .add(currentTicket);
                                  } else {
                                    _selectedRefundEnabledTicket
                                        .remove(currentTicket);
                                  }
                                  setState(() {});
                                },
                                title: Text(
                                    "[${_ticketEnabledList[index].ticketTime} - ${_ticketEnabledList[index].ticketCourse}] n일 남음"),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      "사용 가능한 식권이 존재하지 않습니다!",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
            _ticketDisabledList.isNotEmpty
                ? RefreshIndicator.adaptive(
                    onRefresh: _onRefreshTicketList,
                    child: Column(
                      children: [
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 24,
                                ),
                              ),
                              onPressed: () {
                                if (_selectedRefundDisabledTicket.length ==
                                    _ticketDisabledList.length) {
                                  _selectedRefundDisabledTicket = {};
                                } else {
                                  for (TicketModel ticket
                                      in _ticketDisabledList) {
                                    _selectedRefundDisabledTicket.add(ticket);
                                  }
                                }
                                setState(() {});
                              },
                              child: _selectedRefundDisabledTicket.length ==
                                      _ticketDisabledList.length
                                  ? const Text("전체 해제")
                                  : const Text("전체 선택"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 24,
                                ),
                                backgroundColor: Colors.red,
                              ),
                              onPressed:
                                  _selectedRefundDisabledTicket.isNotEmpty
                                      ? () async {
                                          await swagPlatformDialog(
                                            context: context,
                                            title: "환불",
                                            message: "정말 선택한 식권들을 환불 하시겠습니까?",
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                child: const Text("아니오"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (await context
                                                      .read<TicketProvider>()
                                                      .removeTicket(
                                                          _selectedRefundDisabledTicket)) {
                                                    for (TicketModel ticket
                                                        in _selectedRefundDisabledTicket) {
                                                      _ticketDisabledList
                                                          .remove(ticket);
                                                    }
                                                  }
                                                  _selectedRefundDisabledTicket =
                                                      {};
                                                  setState(() {});
                                                  if (!context.mounted) {
                                                    return;
                                                  }
                                                  context.pop();
                                                },
                                                child: const Text("예"),
                                              ),
                                            ],
                                          );
                                        }
                                      : null,
                              child: const Text(
                                "환불 하기",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _ticketDisabledList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.1,
                                ),
                              ),
                              child: CheckboxListTile.adaptive(
                                value: _selectedRefundDisabledTicket
                                    .contains(_ticketDisabledList[index]),
                                onChanged: (value) {
                                  if (value == null) return;
                                  TicketModel currentTicket =
                                      _ticketDisabledList[index];
                                  if (value) {
                                    _selectedRefundDisabledTicket
                                        .add(currentTicket);
                                  } else {
                                    _selectedRefundDisabledTicket
                                        .remove(currentTicket);
                                  }
                                  setState(() {});
                                },
                                title: Text(
                                    "[${_ticketDisabledList[index].ticketTime} - ${_ticketDisabledList[index].ticketCourse}] 기간 만료"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      "기간이 만료된 식권이 존재하지 않습니다!",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
