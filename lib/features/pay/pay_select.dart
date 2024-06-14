import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/sizes.dart';
import 'package:front_have_a_meal/features/pay/enums/ticket_type_enum.dart';
import 'package:front_have_a_meal/features/pay/ticket_pay_type_screen.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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

  int _ticketPrice = 4200;
  bool _isOutsider = false;

  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    _onChangePrice();
  }

  void _onChangePrice() {
    if (_isOutsider) {
      _ticketPrice = 5000;
    } else {
      const priceMatrix = {
        TicketTimeEnum.breakfast: {
          TicketCourseEnum.a: 4200,
          TicketCourseEnum.b: 4200,
          TicketCourseEnum.c: 4200,
        },
        TicketTimeEnum.lunch: {
          TicketCourseEnum.a: 4200,
          TicketCourseEnum.b: 4600,
          TicketCourseEnum.c: 4900,
        },
        TicketTimeEnum.dinner: {
          TicketCourseEnum.a: 4200,
          TicketCourseEnum.b: 9500,
          TicketCourseEnum.c: 4900,
        },
      };

      _ticketPrice = priceMatrix[_ticketTimeEnum]![_ticketCourseEnum]!;
    }
    setState(() {});
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
            context.pushNamed(
              TicketPayTypeScreen.routeName,
              extra: TicketPayTypeScreenArgs(
                ticketTime: _ticketTimeEnum,
                ticketCourse: _ticketCourseEnum,
                ticketPrice: _ticketPrice,
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
            CheckboxListTile.adaptive(
              value: _isOutsider,
              onChanged: (value) {
                setState(() {
                  _isOutsider = value!;
                });
                _onChangePrice();
              },
              title: const Text("외부인"),
            ),
            const Gap(20),
            Column(
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
                        "가격 : $_ticketPrice원",
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
                  const Text(
                    "보유중인 식권 : n개",
                    style: TextStyle(
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
