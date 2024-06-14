import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/features/pay/enums/ticket_type_enum.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:http/http.dart' as http;

class TicketPayScreenArgs {
  final TicketTimeEnum ticketTime;
  final TicketCourseEnum ticketCourse;
  final int ticketPrice;
  final String payType;
  final String paymentId;

  TicketPayScreenArgs({
    required this.ticketTime,
    required this.ticketCourse,
    required this.ticketPrice,
    required this.payType,
    required this.paymentId,
  });
}

class TicketPayScreen extends StatelessWidget {
  static const routeName = "ticket_pay";
  static const routeURL = "ticket_pay";
  const TicketPayScreen({
    super.key,
    required this.ticketTime,
    required this.ticketCourse,
    required this.ticketPrice,
    required this.payType,
    required this.paymentId,
  });

  final TicketTimeEnum ticketTime;
  final TicketCourseEnum ticketCourse;
  final int ticketPrice;
  final String payType;
  final String paymentId;

  @override
  Widget build(BuildContext context) {
    print(paymentId);
    String screenTitle = "";
    if (payType == "kakaopay") {
      screenTitle = "카카오페이 결제";
    } else if (payType == "tosspay") {
      screenTitle = "토스페이 결제";
    }
    return IamportPayment(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/iamport-logo.png'),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: const Text(
                '잠시만 기다려주세요...',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp83174485',
      /* [필수입력] 결제 데이터 */
      // PG사 : kakaopay, tosspay
      data: PaymentData(
        pg: payType, // PG사
        payMethod: 'card', // 결제수단
        name:
            '${ticketPrice == 5000 ? "외부인" : "내부인"} ${ticketTime == TicketTimeEnum.breakfast ? "조식" : ticketTime == TicketTimeEnum.lunch ? "조식" : "석식"} ${ticketCourse == TicketCourseEnum.a ? "A코스" : ticketCourse == TicketCourseEnum.b ? "B코스" : "C코스"}', // 주문명
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        amount: ticketPrice, // 결제금액
        buyerName: '이재현', // 구매자 이름
        buyerTel: '01049049193', // 구매자 연락처
        buyerEmail: 'dlwogus1027@naver.com', // 구매자 이메일
        // buyerAddr: '서울시 강남구 신사동 661-16', // 구매자 주소
        // buyerPostcode: '06018', // 구매자 우편번호
        appScheme: 'example', // 앱 URL scheme
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) async {
        if (kDebugMode) {
          print(result);
        }

        const String baseUrl = "${HttpIp.apiUrl}/payment/verify";
        final Map<String, String> queryParams = {
          'paymentId': paymentId,
          'impUid': "${result["imp_uid"]}",
        };
        final Uri uri =
            Uri.parse(baseUrl).replace(queryParameters: queryParams);
        final response = await http.get(uri);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          final jsonResponse = jsonDecode(response.body);
          print(jsonResponse);

          swagPlatformDialog(
            context: context,
            title: "결제 완료",
            body: const Text("구매가 정상적으로 완료되었습니다"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  context.pop();
                  context.pop();
                  context.pop();
                },
                child: const Text("확인"),
              ),
            ],
          );
        } else {
          HttpIp.errorPrint(
            context: context,
            title: "통신 오류",
            message: response.body,
          );
        }
      },
    );
  }
}
