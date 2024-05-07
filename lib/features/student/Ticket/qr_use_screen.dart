import 'package:flutter/material.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';

class QrUseScreenArgs {
  QrUseScreenArgs({
    required this.ticketTime,
    required this.ticketCourse,
  });

  final String ticketTime;
  final String ticketCourse;
}

class QrUseScreen extends StatefulWidget {
  static const routeName = "student_ticket_qr";
  static const routeURL = "student_ticket_qr";
  const QrUseScreen({
    super.key,
    required this.ticketTime,
    required this.ticketCourse,
  });

  final String ticketTime;
  final String ticketCourse;

  Map<String, dynamic> toJson() {
    return {
      'ticketTime': ticketTime,
      'ticketCourse': ticketCourse,
    };
  }

  @override
  State<QrUseScreen> createState() => _QrUseScreenState();
}

class _QrUseScreenState extends State<QrUseScreen> {
  List<TicketModel> _ticketEnabledList = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _onCheckedEnabledTicket();
  }

  Future<void> _onCheckedEnabledTicket() async {
    setState(() {
      _isLoading = true;
    });

    _ticketEnabledList = [
      TicketModel(
        ticketId: "1",
        ticketTime: "조식",
        ticketCourse: "A코스",
        ticketPrice: "5000",
      )
    ]; // 사용 가능한 식권 불러오기 통신

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _onRefreshEnabledTicket() async {
    _onCheckedEnabledTicket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("식권 사용"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 34,
            onPressed: _onRefreshEnabledTicket,
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : _ticketEnabledList.isNotEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Icon(
                        Icons.qr_code_2,
                        size: 300,
                      ),
                    ),
                  ],
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
    );
  }
}
