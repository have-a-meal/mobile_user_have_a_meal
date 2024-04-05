import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:front_have_a_meal/providers/ticket_provider.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:front_have_a_meal/widget_tools/text_divider.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StudentQrScreenArgs {
  StudentQrScreenArgs({
    required this.ticketTime,
    required this.ticketCourse,
  });

  final String ticketTime;
  final String ticketCourse;
}

class StudentQrScreen extends StatefulWidget {
  static const routeName = "student_ticket_qr";
  static const routeURL = "student_ticket_qr";
  const StudentQrScreen({
    super.key,
    required this.ticketTime,
    required this.ticketCourse,
  });

  final String ticketTime;
  final String ticketCourse;

  @override
  State<StudentQrScreen> createState() => _StudentQrScreenState();
}

class _StudentQrScreenState extends State<StudentQrScreen> {
  List<TicketModel> _ticketEnabledList = [];
  List<TicketModel> _ticketDisabledList = [];
  String _selectedQRTicket = "";
  // 선택한 환불 티켓
  Set<TicketModel> _selectedRefundDisabledTicket = {};
  Set<TicketModel> _selectedRefundEnabledTicket = {};

  bool _isRefund = false;

  @override
  void initState() {
    super.initState();

    _onCheckedEnabledTicket();
  }

  Future<void> _onCheckedEnabledTicket() async {
    _ticketEnabledList = [];
    _ticketDisabledList = [];

    for (TicketModel ticket in context
        .read<TicketProvider>()
        .getTicketList(widget.ticketTime, widget.ticketCourse)) {
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
      _selectedQRTicket = _ticketEnabledList[0].ticketId;
    }

    setState(() {});
  }

  Future<void> _onRefreshTicketList() async {
    _onCheckedEnabledTicket();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: RefreshIndicator.adaptive(
        onRefresh: _onRefreshTicketList,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: false,
                floating: false,
                centerTitle: true,
                surfaceTintColor: Colors.orange.shade100,
                title: const Text("식권 사용"),
                backgroundColor: Colors.orange.shade100,
              ),
              const SliverToBoxAdapter(
                child: Center(
                  child: Icon(
                    Icons.qr_code_2,
                    size: 200,
                  ),
                ),
              ),
              // const SliverToBoxAdapter(
              //   child: TextDivider(
              //     text: "식권 선택",
              //     fontSize: 24,
              //   ),
              // ),
              const SliverAppBar(
                pinned: true,
                floating: false,
                surfaceTintColor: Colors.white,
                automaticallyImplyLeading: false,
                title: TextDivider(
                  text: "사용할 식권 선택",
                  fontSize: 24,
                ),
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashFactory: NoSplash.splashFactory,
                  tabs: [
                    Tab(text: "사용가능"),
                    Tab(text: "사용불가능"),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(20),
                      !_isRefund
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: ElevatedButton(
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
                                  onPressed: () {
                                    setState(() {
                                      _isRefund = true;
                                    });
                                  },
                                  child: const Text(
                                    "환불 하기",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: ElevatedButton(
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
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isRefund = false;
                                    });
                                  },
                                  child: const Text(
                                    "QR 사용 하기",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      !_isRefund
                          ? ListView.builder(
                              itemCount: _ticketEnabledList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.1,
                                  ),
                                ),
                                child: RadioListTile.adaptive(
                                  value: _ticketEnabledList[index].ticketId,
                                  groupValue: _selectedQRTicket,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedQRTicket = value ?? "";
                                    });
                                  },
                                  title: Text(
                                      "${_ticketEnabledList[index].ticketId}. $index일 경과"),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                const Gap(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                        if (_selectedRefundEnabledTicket
                                                .length ==
                                            _ticketEnabledList.length) {
                                          _selectedRefundEnabledTicket = {};
                                        } else {
                                          for (TicketModel ticket
                                              in _ticketEnabledList) {
                                            _selectedRefundEnabledTicket
                                                .add(ticket);
                                          }
                                        }
                                        setState(() {});
                                      },
                                      child:
                                          _selectedRefundEnabledTicket.length ==
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
                                      onPressed: _selectedRefundEnabledTicket
                                              .isNotEmpty
                                          ? () async {
                                              await swagPlatformDialog(
                                                context: context,
                                                title: "환불",
                                                message:
                                                    "정말 선택한 식권들을 환불 하시겠습니까?",
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      context.pop();
                                                    },
                                                    child: const Text("아니오"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              TicketProvider>()
                                                          .removeTicket(
                                                              _selectedRefundEnabledTicket);
                                                      for (TicketModel ticket
                                                          in _selectedRefundEnabledTicket) {
                                                        _ticketEnabledList
                                                            .remove(ticket);
                                                      }
                                                      _selectedRefundEnabledTicket =
                                                          {};
                                                      setState(() {});
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
                                ListView.builder(
                                  itemCount: _ticketEnabledList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                          "${_ticketEnabledList[index].ticketId}. $index일 경과"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
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
                            onPressed: _selectedRefundDisabledTicket.isNotEmpty
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
                                          onPressed: () {
                                            context
                                                .read<TicketProvider>()
                                                .removeTicket(
                                                    _selectedRefundDisabledTicket);
                                            for (TicketModel ticket
                                                in _selectedRefundDisabledTicket) {
                                              _ticketDisabledList
                                                  .remove(ticket);
                                            }
                                            _selectedRefundDisabledTicket = {};
                                            setState(() {});
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
                      ListView.builder(
                        itemCount: _ticketDisabledList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                                "${_ticketDisabledList[index].ticketId}. $index일 경과"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
