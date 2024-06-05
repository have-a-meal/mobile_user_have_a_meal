import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/pay/enums/ticket_type_enum.dart';
import 'package:go_router/go_router.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class TicketPayScreenArgs {
  final TicketTimeEnum ticketTime;
  final TicketCourseEnum ticketCourse;
  final int ticketPrice;
  final String payType;

  TicketPayScreenArgs({
    required this.ticketTime,
    required this.ticketCourse,
    required this.ticketPrice,
    required this.payType,
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
  });

  final TicketTimeEnum ticketTime;
  final TicketCourseEnum ticketCourse;
  final int ticketPrice;
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
      callback: (Map<String, String> result) {
        if (kDebugMode) {
          print(result);
        }
        context.pop();
        context.pop();
        context.pop();
      },
    );
  }
}
