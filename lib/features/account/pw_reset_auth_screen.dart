import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/pw_reset_screen.dart';
import 'package:front_have_a_meal/features/account/widgets/bottom_button.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PwResetAuthScreen extends StatefulWidget {
  static const routeName = "pw_reset";
  static const routeURL = "/pw_reset";
  const PwResetAuthScreen({super.key});

  @override
  State<PwResetAuthScreen> createState() => _PwResetAuthScreenState();
}

class _PwResetAuthScreenState extends State<PwResetAuthScreen> {
  bool _isSubmitted = false;
  bool _isBarrier = false;

  void _onCheckResetData() {
    setState(() {
      _isSubmitted = (_outsiderEmailController.text.trim().isNotEmpty &&
              _outsiderEmailErrorText == null) &&
          (_outsiderEmailAuthController.text.trim().isNotEmpty &&
              _outsiderEmailAuthErrorText == null &&
              _isEmailAuth);
    });
  }

  void _onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  // ID 찾기 API
  void _onSearchPw() async {
    swagPlatformDialog(
      context: context,
      title: "비밀번호 재설정",
      message: "비밀번호를 재설정하시겠습니까?",
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("아니오"),
        ),
        ElevatedButton(
          onPressed: () {
            context.pushNamed(pwResetScreen.routeName);
          },
          child: const Text("네"),
        ),
      ],
    );
  }

  // 이메일 정규식
  final RegExp _regExpEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final TextEditingController _outsiderEmailController =
      TextEditingController();
  String? _outsiderEmailErrorText;
  final TextEditingController _outsiderEmailAuthController =
      TextEditingController();
  String? _outsiderEmailAuthErrorText;
  bool _isEmailAuth = false;

  void _validateOutsiderEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _outsiderEmailErrorText = '이메일을 입력하세요.';
      });
    } else if (!_regExpEmail.hasMatch(value)) {
      setState(() {
        _outsiderEmailErrorText = "이메일 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _outsiderEmailErrorText = null;
      });
      _onCheckResetData();
    }
  }

  void _validateOutsiderEmailAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _outsiderEmailAuthErrorText = '인증코드를 입력하세요.';
      });
    } else {
      setState(() {
        _outsiderEmailAuthErrorText = null;
      });
      _onCheckResetData();
    }
  }

  // 이메일 인증코드 요청하기 API
  void _onRequestEmailAuthCode() async {}

  // 이메일 인증하기 API
  void _onCheckEmailAuthCode() async {
    setState(() {
      _isEmailAuth = !_isEmailAuth;
    });
    _onCheckResetData();
  }

  @override
  void dispose() {
    _outsiderEmailController.dispose();
    _outsiderEmailAuthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: BottomButton(
          onPressed: _isSubmitted ? _onSearchPw : null,
          text: "비밀번호 재설정",
          isClicked: _isSubmitted,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _outsiderEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: '이메일',
                            errorText: _outsiderEmailErrorText,
                            counterText: '', // 글자수 제한 표시 없애기
                            labelStyle: TextStyle(
                              color: _outsiderEmailErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: _onChangeBarrier,
                          onChanged: _validateOutsiderEmail,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckResetData();
                          },
                        ),
                      ),
                      const Gap(6),
                      ElevatedButton(
                        onPressed: _outsiderEmailController.text.isNotEmpty &&
                                _outsiderEmailErrorText == null
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
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _outsiderEmailAuthController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '인증코드',
                            // errorText: _studentIdAuthErrorText,
                            labelStyle: TextStyle(
                              color: _outsiderEmailAuthErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.numbers_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: _onChangeBarrier,
                          onChanged: _validateOutsiderEmailAuth,
                        ),
                      ),
                      const Gap(6),
                      ElevatedButton(
                        onPressed: _outsiderEmailAuthController.text.isNotEmpty
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
      ),
    );
  }
}
