import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/widgets/bottom_button.dart';
import 'package:front_have_a_meal/features/student/profile/student_Infrom_update_screen.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class StudentEmailAuthScreen extends StatefulWidget {
  static const routeName = "student_email_auth";
  static const routeURL = "student_email_auth";
  const StudentEmailAuthScreen({super.key});

  @override
  State<StudentEmailAuthScreen> createState() => _StudentEmailAuthScreenState();
}

class _StudentEmailAuthScreenState extends State<StudentEmailAuthScreen> {
  bool _isBarrier = false;
  bool _isSubmitted = false;

  void _onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  void _onCheckData() {
    setState(() {
      _isSubmitted = (_emailController.text.trim().isNotEmpty &&
              _emailErrorText == null) &&
          (_emailAuthController.text.trim().isNotEmpty &&
              _emailAuthErrorText == null &&
              _isEmailAuth);
    });
  }

  // 이메일 정규식
  final RegExp _regExpEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final TextEditingController _emailController = TextEditingController();
  String? _emailErrorText;
  final TextEditingController _emailAuthController = TextEditingController();
  String? _emailAuthErrorText;
  bool _isEmailAuth = false;

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorText = '이메일을 입력하세요.';
      });
    } else if (!_regExpEmail.hasMatch(value)) {
      setState(() {
        _emailErrorText = "이메일 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _emailErrorText = null;
      });
      _onCheckData();
    }
  }

  void _validateEmailAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailAuthErrorText = '인증코드를 입력하세요.';
      });
    } else {
      setState(() {
        _emailAuthErrorText = null;
      });
      _onCheckData();
    }
  }

  // 내 정보 수정 페이지로 이동
  void _onPushNextPage() {
    context.pushNamed(StudentInfromUpdateScreen.routeName);
  }

  // 이메일 인증코드 요청하기 API
  void _onRequestEmailAuthCode() async {}

  // 이메일 인증하기 API
  void _onCheckEmailAuthCode() async {
    setState(() {
      _isEmailAuth = !_isEmailAuth;
    });
    _onCheckData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이메일 인증"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: BottomButton(
          onPressed: _isSubmitted ? _onPushNextPage : null,
          text: "다음으로",
          isClicked: _isSubmitted,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Column(
                children: [
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: '이메일',
                            errorText: _emailErrorText,
                            counterText: '', // 글자수 제한 표시 없애기
                            labelStyle: TextStyle(
                              color: _emailErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: _onChangeBarrier,
                          onChanged: _validateEmail,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckData();
                          },
                        ),
                      ),
                      const Gap(6),
                      ElevatedButton(
                        onPressed: _emailController.text.isNotEmpty &&
                                _emailErrorText == null
                            ? _onRequestEmailAuthCode
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(23),
                          textStyle: const TextStyle(fontSize: 14),
                          backgroundColor: Colors.orange.shade200,
                          shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "코드요청",
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _emailAuthController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '인증코드',
                            // errorText: _studentIdAuthErrorText,
                            labelStyle: TextStyle(
                              color: _emailAuthErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.numbers_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: _onChangeBarrier,
                          onChanged: _validateEmailAuth,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckData();
                          },
                        ),
                      ),
                      const Gap(6),
                      ElevatedButton(
                        onPressed: _emailAuthController.text.isNotEmpty
                            ? _onCheckEmailAuthCode
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(23),
                          textStyle: const TextStyle(fontSize: 14),
                          backgroundColor: Colors.orange.shade200,
                          shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "인증하기",
                        ),
                      ),
                    ],
                  ),
                  _isEmailAuth
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            "인증이 완료되었습니다!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.lightGreen,
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            "인증이 필요합니다!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          if (_isBarrier)
            ModalBarrier(
              // color: _barrierAnimation,
              color: Colors.transparent,
              // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
              dismissible: true,
              // 자신을 클릭하면 실행되는 함수
              onDismiss: () {
                setState(() {
                  _isBarrier = false;
                  FocusScope.of(context).unfocus();
                });
              },
            ),
        ],
      ),
    );
  }
}
