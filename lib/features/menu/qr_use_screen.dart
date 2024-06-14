import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:gap/gap.dart';

class QrUseScreenArgs {
  QrUseScreenArgs({
    required this.ticketTime,
    required this.ticketCourse,
  });

  final String ticketTime;
  final String ticketCourse;
}

class QrUseScreen extends StatefulWidget {
  static const routeName = "use_ticket_qr";
  static const routeURL = "use_ticket_qr";
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
  final List<TicketModel> _ticketEnabledList = [];

  bool _isLoading = true;

  Timer? _timer;
  int _start = 180; // 3분을 초 단위로 환산한 값

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
    _onCheckedEnabledTicket();
  }

  void startTimer() {
    // 타이머가 이미 실행중이면 중복 실행 방지
    if (_timer != null) {
      _timer!.cancel();
    }

    // 타이머 시작
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        // 시간이 모두 경과하면 타이머 종료
        _timer!.cancel();
        if (kDebugMode) {
          print("시간 종료!");
        }
      }
    });
  }

  Future<void> _onCheckedEnabledTicket() async {
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _onRefreshEnabledTicket() async {
    setState(() {
      _start = 180;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 위젯이 소멸될 때 타이머도 정지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("식권 사용"),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh),
        //     iconSize: 34,
        //     onPressed: _onRefreshEnabledTicket,
        //   )
        // ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : _ticketEnabledList.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _onRefreshEnabledTicket,
                      icon: const Icon(Icons.refresh),
                      label: Text(
                        '남은 시간 : $_start초',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const Gap(20),
                    const Center(
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
