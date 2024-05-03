import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_have_a_meal/models/pay_check_model.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class StudentPayCheckScreen extends StatefulWidget {
  static const routeName = "student_pay_check";
  static const routeURL = "student_pay_check";
  const StudentPayCheckScreen({super.key});

  @override
  State<StudentPayCheckScreen> createState() => _StudentPayCheckScreenState();
}

class _StudentPayCheckScreenState extends State<StudentPayCheckScreen> {
  bool _isLoading = true;
  String _payTypeFilter = "";
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

    _payCheckListData.addAll([
      PayCheckModel(
          payId: "1",
          payType: "환불",
          payCourse: "A",
          payPrice: 5000,
          payDate: DateTime.now()),
      PayCheckModel(
          payId: "1",
          payType: "결제",
          payCourse: "A",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 1))),
      PayCheckModel(
          payId: "2",
          payType: "결제",
          payCourse: "B",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 2))),
      PayCheckModel(
          payId: "3",
          payType: "결제",
          payCourse: "C",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 3))),
      PayCheckModel(
          payId: "4",
          payType: "결제",
          payCourse: "A",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 4))),
      PayCheckModel(
          payId: "5",
          payType: "환불",
          payCourse: "B",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 5))),
      PayCheckModel(
          payId: "5",
          payType: "결제",
          payCourse: "B",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 6))),
      PayCheckModel(
          payId: "6",
          payType: "결제",
          payCourse: "C",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 7))),
      PayCheckModel(
          payId: "7",
          payType: "결제",
          payCourse: "A",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 8))),
      PayCheckModel(
          payId: "8",
          payType: "결제",
          payCourse: "B",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 9))),
      PayCheckModel(
          payId: "9",
          payType: "환불",
          payCourse: "C",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 10))),
      PayCheckModel(
          payId: "9",
          payType: "결제",
          payCourse: "C",
          payPrice: 5000,
          payDate: DateTime.now().subtract(const Duration(days: 11))),
    ]);

    _payCheckListView.addAll(_payCheckListData);
    _payCheckListView.sort((a, b) => b.payDate.compareTo(a.payDate));

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _onRefreshPayList() async {
    _payCheckListView = [];
    _payCheckListView.addAll(_payCheckListData);
    _payTypeFilter = "";
    _payCourseFilter = "";
    _payDateFilter = "최근순";

    _filterList();

    setState(() {});
  }

  void _filterList() {
    if (_payTypeFilter.isNotEmpty && _payCourseFilter.isNotEmpty) {
      _payCheckListView = _payCheckListData
          .where((payCheck) =>
              payCheck.payType == _payTypeFilter &&
              payCheck.payCourse == _payCourseFilter)
          .toList();
    } else if (_payTypeFilter.isNotEmpty) {
      _payCheckListView = _payCheckListData
          .where((payCheck) => payCheck.payType == _payTypeFilter)
          .toList();
    } else if (_payCourseFilter.isNotEmpty) {
      _payCheckListView = _payCheckListData
          .where((payCheck) => payCheck.payCourse == _payCourseFilter)
          .toList();
    } else {
      _payCheckListView = _payCheckListData.toList();
    }

    // 날짜 필터 적용
    if (_payDateFilter == "최신순") {
      _payCheckListView.sort((a, b) => b.payDate.compareTo(a.payDate));
    } else if (_payDateFilter == "오래된순") {
      _payCheckListView.sort((a, b) => a.payDate.compareTo(b.payDate));
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
                            value: _payTypeFilter,
                            items: const [
                              DropdownMenuItem(
                                value: "",
                                child: Text("전체"),
                              ),
                              DropdownMenuItem(
                                value: "결제",
                                child: Text("결제"),
                              ),
                              DropdownMenuItem(
                                value: "환불",
                                child: Text("환불"),
                              ),
                            ],
                            onChanged: (value) {
                              _payTypeFilter = value as String;
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
                            hint: const Text("코스"),
                            items: const [
                              DropdownMenuItem(
                                value: "",
                                child: Text("전체"),
                              ),
                              DropdownMenuItem(
                                value: "A",
                                child: Text("A코스"),
                              ),
                              DropdownMenuItem(
                                value: "B",
                                child: Text("B코스"),
                              ),
                              DropdownMenuItem(
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
                              horizontal: 30,
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
                                          _payCheckListView[index].payCourse ==
                                                  "A"
                                              ? const Text(
                                                  "A코스",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.lightGreen,
                                                  ),
                                                )
                                              : _payCheckListView[index]
                                                          .payCourse ==
                                                      "B"
                                                  ? const Text(
                                                      "B코스",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.lightBlue,
                                                      ),
                                                    )
                                                  : const Text(
                                                      "C코스",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                          _payCheckListView[index].payType ==
                                                  "환불"
                                              ? Text(
                                                  "[${_payCheckListView[index].payType}]",
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              : Text(
                                                  "[${_payCheckListView[index].payType}]",
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ],
                                      ),
                                      const Divider(),
                                      Text(
                                        _payCheckListView[index].payType == "환불"
                                            ? "환불날짜 : ${DateFormat('yyyy-MM-dd(E) HH:mm', 'ko_KR').format(_payCheckListView[index].payDate)}"
                                            : "구매날짜 : ${DateFormat('yyyy-MM-dd(E) HH:mm', 'ko_KR').format(_payCheckListView[index].payDate)}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        _payCheckListView[index].payType == "환불"
                                            ? "환불가격 : ${_payCheckListView[index].payPrice}원"
                                            : "구매가격 : ${_payCheckListView[index].payPrice}원",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
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
