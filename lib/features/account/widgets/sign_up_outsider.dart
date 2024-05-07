import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/widgets/bottom_button.dart';
import 'package:gap/gap.dart';

class SignUpOutsider extends StatefulWidget {
  const SignUpOutsider({super.key});

  @override
  State<SignUpOutsider> createState() => _SignUpOutsiderState();
}

class _SignUpOutsiderState extends State<SignUpOutsider> {
  bool _isSubmitted = false;
  bool _isBarrier = false;

  void _onCheckOutsiderData() {
    setState(() {
      _isSubmitted = (_outsiderPwController.text.trim().isNotEmpty &&
              _outsiderPwErrorText == null) &&
          (_outsiderPwAuthController.text.trim().isNotEmpty &&
              _outsiderPwAuthErrorText == null) &&
          (_outsiderNameController.text.trim().isNotEmpty &&
              _outsiderNameErrorText == null) &&
          (_outsiderPhoneNumberController.text.trim().isNotEmpty &&
              _outsiderPhoneNumberErrorText == null) &&
          (_outsiderEmailController.text.trim().isNotEmpty &&
              _outsiderEmailErrorText == null) &&
          (_outsiderEmailAuthController.text.trim().isNotEmpty &&
              _outsiderEmailAuthErrorText == null &&
              _isEmailAuth);
    });
  }

  void onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  // 외부인 회원가입 API
  void _onSignUpOutsider() async {}

  // 이메일 인증코드 요청하기 API
  void _onRequestEmailAuthCode() async {}

  // 이메일 인증하기 API
  void _onCheckEmailAuthCode() async {
    setState(() {
      _isEmailAuth = !_isEmailAuth;
    });
    _onCheckOutsiderData();
  }

  // 비밀번호 정규식
  final RegExp _regExpPw =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
  // 전화번호 정규식
  final RegExp _regExpPhoneNumber = RegExp(
      r'^(02|0[3-9][0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$|^(02|0[3-9][0-9]{1,2})[0-9]{7,8}$|^01[0-9]{9}$|^070-[0-9]{4}-[0-9]{4}$|^070[0-9]{8}$');
  // 이메일 정규식
  final RegExp _regExpEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final TextEditingController _outsiderPwController = TextEditingController();
  String? _outsiderPwErrorText;
  final TextEditingController _outsiderPwAuthController =
      TextEditingController();
  String? _outsiderPwAuthErrorText;
  final TextEditingController _outsiderNameController = TextEditingController();
  String? _outsiderNameErrorText;
  final TextEditingController _outsiderPhoneNumberController =
      TextEditingController();
  String? _outsiderPhoneNumberErrorText;
  final TextEditingController _outsiderEmailController =
      TextEditingController();
  String? _outsiderEmailErrorText;
  final TextEditingController _outsiderEmailAuthController =
      TextEditingController();
  String? _outsiderEmailAuthErrorText;
  bool _isEmailAuth = false;

  void _validateOutsiderPw(String value) {
    if (value.isEmpty) {
      setState(() {
        _outsiderPwErrorText = '비밀번호를 입력하세요!';
      });
    } else if (!_regExpPw.hasMatch(value)) {
      setState(() {
        _outsiderPwErrorText = '영대소문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _outsiderPwErrorText = null;
      });
      _onCheckOutsiderData();
    }
  }

  void _validateOutsiderPwAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _outsiderPwAuthErrorText = '비밀번호 확인을 입력하세요!';
      });
    } else if (value != _outsiderPwController.text) {
      setState(() {
        _outsiderPwAuthErrorText = '비밀번호와 같지 않습니다!';
      });
    } else {
      setState(() {
        _outsiderPwAuthErrorText = null;
      });
      _onCheckOutsiderData();
    }
  }

  void _validateOutsiderName(String value) {
    if (value.isEmpty) {
      setState(() {
        _outsiderNameErrorText = '이름(실명)을 입력하세요.';
      });
    } else {
      setState(() {
        _outsiderNameErrorText = null;
      });
      _onCheckOutsiderData();
    }
  }

  void _validateOutsiderPhoneNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _outsiderPhoneNumberErrorText = '전화번호를 입력하세요.';
      });
    } else if (!_regExpPhoneNumber.hasMatch(value)) {
      setState(() {
        _outsiderPhoneNumberErrorText = "전화번호 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _outsiderPhoneNumberErrorText = null;
      });
      _onCheckOutsiderData();
    }
  }

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
      _onCheckOutsiderData();
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
      _onCheckOutsiderData();
    }
  }

  @override
  void dispose() {
    _outsiderPwController.dispose();
    _outsiderPwAuthController.dispose();
    _outsiderNameController.dispose();
    _outsiderPhoneNumberController.dispose();
    _outsiderEmailAuthController.dispose();
    _outsiderEmailController.dispose();

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
          onPressed: _isSubmitted ? _onSignUpOutsider : null,
          text: "회원가입",
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
                          maxLength: 254,
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
                          onTap: onChangeBarrier,
                          onChanged: _validateOutsiderEmail,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckOutsiderData();
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
                          onTap: onChangeBarrier,
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
                  const Gap(10),
                  if (_isEmailAuth &&
                      _outsiderEmailController.text.trim().isNotEmpty &&
                      _outsiderEmailErrorText == null)
                    Column(
                      children: [
                        TextFormField(
                          controller: _outsiderNameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: '이름(실명)',
                            errorText: _outsiderNameErrorText,
                            labelStyle: TextStyle(
                              color: _outsiderNameErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.badge_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: onChangeBarrier,
                          onChanged: _validateOutsiderName,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckOutsiderData();
                          },
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: _outsiderPhoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '전화번호',
                            errorText: _outsiderPhoneNumberErrorText,
                            labelStyle: TextStyle(
                              color: _outsiderPhoneNumberErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.phone_iphone_rounded,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: onChangeBarrier,
                          onChanged: _validateOutsiderPhoneNumber,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckOutsiderData();
                          },
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: _outsiderPwController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: '비밀번호',
                            errorText: _outsiderPwErrorText,
                            labelStyle: TextStyle(
                              color: _outsiderPwErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: onChangeBarrier,
                          onChanged: _validateOutsiderPw,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckOutsiderData();
                          },
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: _outsiderPwAuthController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: '비밀번호 확인',
                            errorText: _outsiderPwAuthErrorText,
                            labelStyle: TextStyle(
                              color: _outsiderPwAuthErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_person_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: onChangeBarrier,
                          onChanged: _validateOutsiderPwAuth,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckOutsiderData();
                          },
                        ),
                      ],
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
