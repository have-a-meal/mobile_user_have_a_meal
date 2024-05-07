import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/sign_in_screen.dart';
import 'package:front_have_a_meal/features/account/widgets/bottom_button.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PwResetScreen extends StatefulWidget {
  static const routeName = "reset_password";
  static const routeURL = "reset_password";
  const PwResetScreen({super.key});

  @override
  State<PwResetScreen> createState() => _PwResetScreenState();
}

class _PwResetScreenState extends State<PwResetScreen> {
  bool _isSubmitted = false;
  bool _isBarrier = false;

  void _onCheckResetData() {
    setState(() {
      _isSubmitted = (_resetPwController.text.trim().isNotEmpty &&
              _resetPwErrorText == null) &&
          (_resetPwAuthController.text.trim().isNotEmpty &&
              _resetPwAuthErrorText == null);
    });
  }

  void onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  // 비밀번호 재설정 API
  void _onResetPw() async {
    swagPlatformDialog(
      context: context,
      title: "비밀번호 재설정",
      message: "재설정이 완료되었습니다.",
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
            context.goNamed(SignInScreen.routeName);
          },
          child: const Text("알겠습니다"),
        ),
      ],
    );
  }

  // 비밀번호 정규식
  final RegExp _regExpPw =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

  final TextEditingController _resetPwController = TextEditingController();
  String? _resetPwErrorText;
  final TextEditingController _resetPwAuthController = TextEditingController();
  String? _resetPwAuthErrorText;

  void _validateResetPw(String value) {
    if (value.isEmpty) {
      setState(() {
        _resetPwErrorText = '비밀번호를 입력하세요!';
      });
    } else if (!_regExpPw.hasMatch(value)) {
      setState(() {
        _resetPwErrorText = '영대소문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _resetPwErrorText = null;
      });
      _onCheckResetData();
    }
  }

  void _validateResetPwAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _resetPwAuthErrorText = '비밀번호 확인을 입력하세요!';
      });
    } else if (value != _resetPwController.text) {
      setState(() {
        _resetPwAuthErrorText = '비밀번호와 같지 않습니다!';
      });
    } else {
      setState(() {
        _resetPwAuthErrorText = null;
      });
      _onCheckResetData();
    }
  }

  @override
  void dispose() {
    _resetPwController.dispose();
    _resetPwAuthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("비밀번호 재설정"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: BottomButton(
          onPressed: _isSubmitted ? _onResetPw : null,
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
                  TextFormField(
                    controller: _resetPwController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      errorText: _resetPwErrorText,
                      labelStyle: TextStyle(
                        color: _resetPwErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: onChangeBarrier,
                    onChanged: _validateResetPw,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckResetData();
                    },
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: _resetPwAuthController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호 확인',
                      errorText: _resetPwAuthErrorText,
                      labelStyle: TextStyle(
                        color: _resetPwAuthErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_person_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: onChangeBarrier,
                    onChanged: _validateResetPwAuth,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckResetData();
                    },
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
