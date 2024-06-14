import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/models/pay_check_model.dart';
import 'package:front_have_a_meal/providers/user_provider.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PayCheckScreen extends StatefulWidget {
  static const routeName = "student_pay_check";
  static const routeURL = "student_pay_check";
  const PayCheckScreen({super.key});

  @override
  State<PayCheckScreen> createState() => _PayCheckScreenState();
}

class _PayCheckScreenState extends State<PayCheckScreen> {
  bool _isLoading = true;
  String _payTimeFilter = "";
  String _payCourseFilter = "";
  String _payDateFilter = "최근순";
  final List<PayCheckModel> _payCheckListData = [];
  List<PayCheckModel> _payCheckListView = [];

  @override
  void initState() {
    super.initState();

    _initPayList();
  }

  Future<void> _initPayList() async {
    setState(() {
      _isLoading = true;
    });

    Uri url = Uri.parse(
        "${HttpIp.apiUrl}/payment/transaction/${context.read<UserProvider>().userData!.memberId}");
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        _payCheckListData.clear(); // 기존 데이터 초기화
        for (var item in jsonResponse) {
          _payCheckListData.add(PayCheckModel.fromJson(item));
        }
      });

      _filterList();
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _onRefreshPayList() async {
    _payCheckListView = [];
    _payCheckListView.addAll(_payCheckListData);
    _payTimeFilter = "";
    _payCourseFilter = "";
    _payDateFilter = "최근순";

    _filterList();

    setState(() {});
  }

  void _filterList() {
    if (_payTimeFilter.isNotEmpty && _payCourseFilter.isNotEmpty) {
      _payCheckListView = _payCheckListData
          .where((payCheck) =>
              payCheck.timing == _payTimeFilter &&
              payCheck.courseType == _payCourseFilter)
          .toList();
    } else if (_payTimeFilter.isNotEmpty) {
      _payCheckListView = _payCheckListData
          .where((payCheck) => payCheck.timing == _payTimeFilter)
          .toList();
    } else if (_payCourseFilter.isNotEmpty) {
      _payCheckListView = _payCheckListData
          .where((payCheck) => payCheck.courseType == _payCourseFilter)
          .toList();
    } else {
      _payCheckListView = _payCheckListData.toList();
    }

    // 날짜 필터 적용
    if (_payDateFilter == "최근순") {
      _payCheckListView.sort((a, b) => b.accountDate.compareTo(a.accountDate));
    } else if (_payDateFilter == "오래된순") {
      _payCheckListView.sort((a, b) => a.accountDate.compareTo(b.accountDate));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("결제 내역"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ), // 여백을 조정합니다.
                        decoration: BoxDecoration(
                          color: Colors.white, // 배경색 설정
                          borderRadius: BorderRadius.circular(10.0), // 모서리 둥글게
                          border: Border.all(
                            color: Colors.grey, // 테두리 색상
                            width: 1.0, // 테두리 두께
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _payTimeFilter,
                            items: [
                              DropdownMenuItem(
                                value: "",
                                child: _payTimeFilter != ""
                                    ? const Text("전체")
                                    : const Text("시간"),
                              ),
                              const DropdownMenuItem(
                                value: "조식",
                                child: Text("조식"),
                              ),
                              const DropdownMenuItem(
                                value: "중식",
                                child: Text("중식"),
                              ),
                              const DropdownMenuItem(
                                value: "석식",
                                child: Text("석식"),
                              ),
                            ],
                            onChanged: (value) {
                              _payTimeFilter = value as String;
                              _filterList();
                            },
                          ),
                        ),
                      ),
                      const Gap(10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2), // 여백을 조정합니다.
                        decoration: BoxDecoration(
                          color: Colors.white, // 배경색 설정
                          borderRadius: BorderRadius.circular(10.0), // 모서리 둥글게
                          border: Border.all(
                            color: Colors.grey, // 테두리 색상
                            width: 1.0, // 테두리 두께
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _payCourseFilter,
                            items: [
                              DropdownMenuItem(
                                value: "",
                                child: _payCourseFilter != ""
                                    ? const Text("전체")
                                    : const Text("코스"),
                              ),
                              const DropdownMenuItem(
                                value: "A",
                                child: Text("A코스"),
                              ),
                              const DropdownMenuItem(
                                value: "B",
                                child: Text("B코스"),
                              ),
                              const DropdownMenuItem(
                                value: "C",
                                child: Text("C코스"),
                              ),
                            ],
                            onChanged: (value) {
                              _payCourseFilter = value as String;
                              _filterList();
                            },
                          ),
                        ),
                      ),
                      const Gap(10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2), // 여백을 조정합니다.
                        decoration: BoxDecoration(
                          color: Colors.white, // 배경색 설정
                          borderRadius: BorderRadius.circular(10.0), // 모서리 둥글게
                          border: Border.all(
                            color: Colors.grey, // 테두리 색상
                            width: 1.0, // 테두리 두께
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _payDateFilter,
                            items: const [
                              DropdownMenuItem(
                                value: "최근순",
                                child: Text("최근순"),
                              ),
                              DropdownMenuItem(
                                value: "오래된순",
                                child: Text("오래된순"),
                              ),
                            ],
                            onChanged: (value) {
                              _payDateFilter = value as String;
                              _filterList();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _payCheckListView.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text(
                            "결제 내역이 존재하지 않습니다!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: RefreshIndicator.adaptive(
                          onRefresh: _onRefreshPayList,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            itemCount: _payCheckListView.length,
                            separatorBuilder: (context, index) => const Gap(10),
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 14,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text:
                                                  "${_payCheckListView[index].timing} ",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${_payCheckListView[index].courseType}코스",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: _payCheckListView[
                                                                    index]
                                                                .courseType ==
                                                            "A"
                                                        ? Colors.lightGreen
                                                        : _payCheckListView[
                                                                        index]
                                                                    .courseType ==
                                                                "B"
                                                            ? Colors.lightBlue
                                                            : Colors.purple,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            _payCheckListView[index].status ==
                                                    "paid"
                                                ? "[결제완료]"
                                                : "[결제 실패]",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: _payCheckListView[index]
                                                          .status ==
                                                      "paid"
                                                  ? Colors.black
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Text(
                                        "날짜 : ${DateFormat('yyyy-MM-dd(E) HH:mm', 'ko_KR').format(_payCheckListView[index].accountDate)}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "가격 : ${_payCheckListView[index].price}원",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      // Text(
                                      //   "결제수단 : ${_payCheckListView[index].pgName} - ${_payCheckListView[index].paymentType}",
                                      //   style: const TextStyle(
                                      //     fontSize: 16,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   "결제수단 : ${_payCheckListView[index].paymentType}",
                                      //   style: const TextStyle(
                                      //     fontSize: 16,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
    );
  }
}
