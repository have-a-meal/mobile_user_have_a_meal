import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class TicketPayScreenArgs {
  final String menuTime;
  final String menuCourse;
  final int menuPrice;
  final String payType;

  TicketPayScreenArgs({
    required this.menuTime,
    required this.menuCourse,
    required this.menuPrice,
    required this.payType,
  });
}

class TicketPayScreen extends StatelessWidget {
  static const routeName = "ticket_pay";
  static const routeURL = "ticket_pay";
  const TicketPayScreen({
    super.key,
    required this.menuTime,
    required this.menuCourse,
    required this.menuPrice,
    required this.payType,
  });

  final String menuTime;
  final String menuCourse;
  final int menuPrice;
  final String payType;

  @override
  Widget build(BuildContext context) {
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
        name: '$menuTime $menuCourse', // 주문명
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        amount: 100, // 결제금액
        buyerName: '이재현', // 구매자 이름
        buyerTel: '01049049193', // 구매자 연락처
        buyerEmail: 'dlwogus1027@naver.com', // 구매자 이메일
        // buyerAddr: '서울시 강남구 신사동 661-16', // 구매자 주소
        // buyerPostcode: '06018', // 구매자 우편번호
        appScheme: 'example', // 앱 URL scheme
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        if (kDebugMode) {
          print(result);
        }
        context.pop();
      },
    );
  }
}
