import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/widgets/bottom_button.dart';
import 'package:gap/gap.dart';

class SignUpStudent extends StatefulWidget {
  const SignUpStudent({super.key});

  @override
  State<SignUpStudent> createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent> {
  bool _isSubmitted = false;
  bool _isBarrier = false;

  void _onCheckStudentData() {
    setState(() {
      _isSubmitted = (_studentIdErrorText == null &&
              _studentIdController.text.trim().isNotEmpty &&
              _studentIdAuth) &&
          (_studentPwController.text.trim().isNotEmpty &&
              _studentPwErrorText == null) &&
          (_studentPwAuthController.text.trim().isNotEmpty &&
              _studentPwAuthErrorText == null) &&
          (_studentNameController.text.trim().isNotEmpty &&
              _studentNameErrorText == null) &&
          (_studentPhoneNumberController.text.trim().isNotEmpty &&
              _studentPhoneNumberErrorText == null);
    });
  }

  void _onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  // 학번 인증코드 요청하기 API
  void _onRequestIdCode() async {}

  // 학번 인증하기 API
  void _onCheckIdAuthCode() async {
    setState(() {
      _studentIdAuth = !_studentIdAuth;
    });
    _onCheckStudentData();
  }

  // 학생 회원가입 API
  void _onSignUpStudent() async {}

  // 학번 정규식
  final RegExp _regExpId = RegExp(r'^\d{8}$');
  // 비밀번호 정규식
  final RegExp _regExpPw =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
  // 전화번호 정규식
  final RegExp _regExpPhoneNumber = RegExp(
      r'^(02|0[3-9][0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$|^(02|0[3-9][0-9]{1,2})[0-9]{7,8}$|^01[0-9]{9}$|^070-[0-9]{4}-[0-9]{4}$|^070[0-9]{8}$');

  final TextEditingController _studentIdController = TextEditingController();
  String? _studentIdErrorText;
  final TextEditingController _studentIdAuthController =
      TextEditingController();
  String? _studentIdAuthErrorText;
  bool _studentIdAuth = false;
  final TextEditingController _studentPwController = TextEditingController();
  String? _studentPwErrorText;
  final TextEditingController _studentPwAuthController =
      TextEditingController();
  String? _studentPwAuthErrorText;
  final TextEditingController _studentNameController = TextEditingController();
  String? _studentNameErrorText;
  final TextEditingController _studentPhoneNumberController =
      TextEditingController();
  String? _studentPhoneNumberErrorText;

  void _validateStudentId(String value) {
    if (value.isEmpty) {
      setState(() {
        _studentIdErrorText = '학번을 입력하세요.';
      });
    } else if (!_regExpId.hasMatch(value)) {
      setState(() {
        _studentIdErrorText = '학번을 제대로 입력해주세요!';
      });
    } else {
      setState(() {
        _studentIdErrorText = null;
      });
      _onCheckStudentData();
    }
  }

  void _validateStudentIdAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _studentIdAuthErrorText = '학번인증코드를 입력하세요.';
      });
    } else {
      setState(() {
        _studentIdAuthErrorText = null;
      });
      _onCheckStudentData();
    }
  }

  void _validateStudentPw(String value) {
    if (value.isEmpty) {
      setState(() {
        _studentPwErrorText = '비밀번호를 입력하세요!';
      });
    } else if (!_regExpPw.hasMatch(value)) {
      setState(() {
        _studentPwErrorText = '영대소문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _studentPwErrorText = null;
      });
      _onCheckStudentData();
    }
  }

  void _validateStudentPwAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _studentPwAuthErrorText = '비밀번호 확인을 입력하세요!';
      });
    } else if (value != _studentPwController.text) {
      setState(() {
        _studentPwAuthErrorText = '비밀번호와 같지 않습니다!';
      });
    } else {
      setState(() {
        _studentPwAuthErrorText = null;
      });
      _onCheckStudentData();
    }
  }

  void _validateStudentName(String value) {
    if (value.isEmpty) {
      setState(() {
        _studentNameErrorText = '이름(실명)을 입력하세요.';
      });
    } else {
      setState(() {
        _studentNameErrorText = null;
      });
      _onCheckStudentData();
    }
  }

  void _validateStudentPhoneNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _studentPhoneNumberErrorText = '전화번호를 입력하세요.';
      });
    } else if (!_regExpPhoneNumber.hasMatch(value)) {
      setState(() {
        _studentPhoneNumberErrorText = "전화번호 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _studentPhoneNumberErrorText = null;
      });
      _onCheckStudentData();
    }
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    _studentIdAuthController.dispose();
    _studentPwController.dispose();
    _studentPwAuthController.dispose();
    _studentNameController.dispose();
    _studentPhoneNumberController.dispose();

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
          onPressed: _isSubmitted ? _onSignUpStudent : null,
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
                          controller: _studentIdController,
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          decoration: InputDecoration(
                            labelText: '학번',
                            suffixText: '@st.yc.ac.kr',
                            errorText: _studentIdErrorText,
                            counterText: '', // 글자수 제한 표시 없애기
                            labelStyle: TextStyle(
                              color: _studentIdErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: _onChangeBarrier,
                          onChanged: _validateStudentId,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _onCheckStudentData();
                          },
                        ),
                      ),
                      const Gap(6),
                      ElevatedButton(
                        onPressed: _studentIdController.text.isNotEmpty &&
                                _studentIdErrorText == null
                            ? _onRequestIdCode
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
                          controller: _studentIdAuthController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '인증코드',
                            // errorText: _studentIdAuthErrorText,
                            labelStyle: TextStyle(
                              color: _studentIdAuthErrorText == null
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            prefixIcon: Icon(
                              Icons.numbers_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: _onChangeBarrier,
                          onChanged: _validateStudentIdAuth,
                        ),
                      ),
                      const Gap(6),
                      ElevatedButton(
                        onPressed: _studentIdAuthController.text.isNotEmpty
                            ? _onCheckIdAuthCode
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
                  _studentIdAuth
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
                  TextFormField(
                    controller: _studentPwController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      errorText: _studentPwErrorText,
                      labelStyle: TextStyle(
                        color: _studentPwErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: _onChangeBarrier,
                    onChanged: _validateStudentPw,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckStudentData();
                    },
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: _studentPwAuthController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호 확인',
                      errorText: _studentPwAuthErrorText,
                      labelStyle: TextStyle(
                        color: _studentPwAuthErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_person_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: _onChangeBarrier,
                    onChanged: _validateStudentPwAuth,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckStudentData();
                    },
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: _studentNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: '이름(실명)',
                      errorText: _studentNameErrorText,
                      labelStyle: TextStyle(
                        color: _studentNameErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.badge_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: _onChangeBarrier,
                    onChanged: _validateStudentName,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckStudentData();
                    },
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: _studentPhoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '전화번호',
                      errorText: _studentPhoneNumberErrorText,
                      labelStyle: TextStyle(
                        color: _studentPhoneNumberErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.phone_iphone_rounded,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: _onChangeBarrier,
                    onChanged: _validateStudentPhoneNumber,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckStudentData();
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
                    _onCheckStudentData();
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
