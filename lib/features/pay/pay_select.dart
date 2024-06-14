import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/constants/sizes.dart';
import 'package:front_have_a_meal/features/pay/enums/ticket_type_enum.dart';
import 'package:front_have_a_meal/features/pay/ticket_pay_type_screen.dart';
import 'package:front_have_a_meal/providers/ticket_provider.dart';
import 'package:front_have_a_meal/providers/user_provider.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PaySelect extends StatefulWidget {
  const PaySelect({
    super.key,
  });

  @override
  State<PaySelect> createState() => _PaySelectState();
}

class _PaySelectState extends State<PaySelect> {
  TicketTimeEnum _ticketTimeEnum = TicketTimeEnum.breakfast;
  TicketCourseEnum _ticketCourseEnum = TicketCourseEnum.a;

  int? _ticketPrice;
  int? _courseId;

  @override
  void initState() {
    super.initState();

    _onChangePrice();
    _onChangeTicketLength();
  }

  Future<void> _onChangeTicketLength() async {}

  Future<void> _onChangePrice() async {
    setState(() {
      _ticketPrice = null;
      _courseId = null;
    });

    const String baseUrl = "${HttpIp.apiUrl}/payment/ticketPrice";
    final Map<String, String> queryParams = {
      'timing': _ticketTimeEnum == TicketTimeEnum.breakfast
          ? "조식"
          : _ticketTimeEnum == TicketTimeEnum.lunch
              ? "조식"
              : "석식",
      'courseType': _ticketCourseEnum == TicketCourseEnum.a
          ? "A"
          : _ticketCourseEnum == TicketCourseEnum.b
              ? "B"
              : "C",
      'memberId': context.read<UserProvider>().userData!.memberId,
    };
    final Uri uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);

      setState(() {
        _ticketPrice = jsonResponse['price'];
        _courseId = jsonResponse['courseId'];
      });
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }
  }

  // 티켓 결제 API
  Future<void> _onTicketPay(BuildContext context) async {
    swagPlatformDialog(
      context: context,
      title: "결제",
      body: Text(
        "${_ticketTimeEnum == TicketTimeEnum.breakfast ? "조식" : _ticketTimeEnum == TicketTimeEnum.lunch ? "조식" : "석식"} ${_ticketCourseEnum == TicketCourseEnum.a ? "A코스" : _ticketCourseEnum == TicketCourseEnum.b ? "B코스" : "C코스"}를 결제하시겠습니까?",
        style: const TextStyle(
          fontSize: Sizes.size16,
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("취소"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_ticketPrice != null) {
              context.pop();
              context.pushNamed(
                TicketPayTypeScreen.routeName,
                extra: TicketPayTypeScreenArgs(
                  ticketTime: _ticketTimeEnum,
                  ticketCourse: _ticketCourseEnum,
                  ticketPrice: _ticketPrice!,
                  courseId: _courseId!,
                ),
              );
            } else {
              swagPlatformDialog(
                context: context,
                title: "통신 오류",
                body: const Text("가격 정보가 존재하지 않습니다!"),
                actions: [
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text("확인"),
                  ),
                ],
              );
            }
          },
          child: const Text("확인"),
        ),
      ],
    );
  }

  Future<void> _onRefresh() async {
    setState(() {});
    _ticketPrice = null;
    _onChangeTicketLength();
    _onChangePrice();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("결제"),
        actions: [
          IconButton(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh),
            iconSize: 34,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(20),
            SegmentedButton(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: TicketTimeEnum.breakfast,
                  label: Text("조식"),
                ),
                ButtonSegment(
                  value: TicketTimeEnum.lunch,
                  label: Text("중식"),
                ),
                ButtonSegment(
                  value: TicketTimeEnum.dinner,
                  label: Text("석식"),
                ),
              ],
              selected: <TicketTimeEnum>{_ticketTimeEnum},
              onSelectionChanged: (Set<TicketTimeEnum> newSelection) {
                setState(() {
                  _ticketTimeEnum = newSelection.first;
                });
                _onChangePrice();
              },
            ),
            const Gap(20),
            SegmentedButton(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: TicketCourseEnum.a,
                  label: Text("A코스"),
                ),
                ButtonSegment(
                  value: TicketCourseEnum.b,
                  label: Text("B코스"),
                ),
                ButtonSegment(
                  value: TicketCourseEnum.c,
                  label: Text("C코스"),
                ),
              ],
              selected: <TicketCourseEnum>{_ticketCourseEnum},
              onSelectionChanged: (Set<TicketCourseEnum> newSelection) {
                setState(() {
                  _ticketCourseEnum = newSelection.first;
                });
                _onChangePrice();
              },
            ),
            const Gap(20),
            // CheckboxListTile.adaptive(
            //   value: _isOutsider,
            //   onChanged: (value) {
            //     setState(() {
            //       _isOutsider = value!;
            //     });
            //     _onChangePrice();
            //   },
            //   title: const Text("외부인"),
            // ),
            // const Gap(20),
            _ticketPrice == null && _courseId == null
                ? const Center(
                    child: Column(
                      children: [
                        Gap(40),
                        CircularProgressIndicator.adaptive(
                          strokeAlign: 10,
                          strokeWidth: 6,
                        ),
                      ],
                    ),
                  )
                : Column(
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
                          borderRadius:
                              BorderRadius.circular(20), // 여기도 둥근 모서리를 적용
                          color: Colors.white, // 배경색 지정
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "시간 : ${_ticketTimeEnum == TicketTimeEnum.breakfast ? "조식" : _ticketTimeEnum == TicketTimeEnum.lunch ? "중식" : "석식"}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "코스 : ${_ticketCourseEnum == TicketCourseEnum.a ? "A코스" : _ticketCourseEnum == TicketCourseEnum.b ? "B코스" : "C코스"}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              _ticketPrice == 0
                                  ? "로딩중..."
                                  : "가격 : $_ticketPrice원",
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
            const Gap(40),
            Padding(
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
                  const Gap(30),
                  Text(
                    "보유중인 식권 : ${context.watch<TicketProvider>().onSearchTicketLength(_ticketTimeEnum == TicketTimeEnum.breakfast ? "조식" : _ticketTimeEnum == TicketTimeEnum.lunch ? "중식" : "석식", _ticketCourseEnum == TicketCourseEnum.a ? "A코스" : _ticketCourseEnum == TicketCourseEnum.b ? "B코스" : "C코스")}개",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
