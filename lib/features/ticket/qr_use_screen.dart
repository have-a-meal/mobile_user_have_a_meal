import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/models/ticket_model.dart';
import 'package:front_have_a_meal/providers/user_provider.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
  String? _qrImage;
  Uint8List? _qrImageBase64;
  String? _accessToken;
  String? _refreshToken;

  bool _isLoading = true;

  Timer? _timer;
  int _start = 10; // 3분을 초 단위로 환산한 값

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
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
      }
    });
  }

  Future<void> _onCheckedEnabledTicket() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse("${HttpIp.apiUrl}/ticket");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "memberId": context.read<UserProvider>().userData!.memberId,
      "courseType": widget.ticketCourse,
      "timing": widget.ticketTime,
      "width": 300,
      "height": 300,
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);

      setState(() {
        _qrImage = jsonResponse['qrCode'];
        _qrImageBase64 = base64Decode(jsonResponse['qrCode']);
        _accessToken = jsonResponse['accessToken'];
        _refreshToken = jsonResponse['refreshToken'];
        startTimer();
      });
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

  Future<void> _onRefreshEnabledTicket() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse("${HttpIp.apiUrl}/ticket/refresh");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "refreshToken": _refreshToken,
      "qrCodeRequestDto": {
        "memberId": context.read<UserProvider>().userData!.memberId,
        "courseType": widget.ticketCourse,
        "timing": widget.ticketTime,
        "width": 300,
        "height": 300,
      }
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);

      setState(() {
        _qrImage = jsonResponse['qrCode'];
        _accessToken = jsonResponse['accessToken'];
        _refreshToken = jsonResponse['refreshToken'];
        _start = 180;
        startTimer();
        setState(() {});
      });
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : _qrImage != null
                  ? _start != 0
                      ? Center(
                          child: Image.memory(_qrImageBase64!),
                        )
                      : const Center(
                          child: Text(
                            "유효 시간이 만료되었습니다!",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
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
          const Gap(20),
          _start != 0
              ? ElevatedButton.icon(
                  onPressed: _onRefreshEnabledTicket,
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    '남은 시간 : $_start초',
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: _onRefreshEnabledTicket,
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    '새로고침',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
        ],
      ),
    );
  }
}
