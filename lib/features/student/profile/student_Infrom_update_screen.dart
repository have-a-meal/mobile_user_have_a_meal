import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/widgets/bottom_button.dart';
import 'package:front_have_a_meal/features/student/student_navigation_screen.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// class StudentInfromUpdateScreenArgs {
//   final UpdateType updateType;

//   StudentInfromUpdateScreenArgs({required this.updateType});
// }

class StudentInfromUpdateScreen extends StatefulWidget {
  static const routeName = "student_infrom_update";
  static const routeURL = "student_infrom_update";
  const StudentInfromUpdateScreen({
    super.key,
  });

  @override
  State<StudentInfromUpdateScreen> createState() =>
      _StudentInfromUpdateScreenState();
}

class _StudentInfromUpdateScreenState extends State<StudentInfromUpdateScreen> {
  bool _isBarrier = false;
  bool _isSubmitted = false;

  void _onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  void _onCheckUserData() {
    setState(() {
      _isSubmitted = (_pwController.text.trim().isNotEmpty &&
              _pwErrorText == null) &&
          (_pwAuthController.text.trim().isNotEmpty &&
              _pwAuthErrorText == null) &&
          (_nameController.text.trim().isNotEmpty && _nameErrorText == null) &&
          (_phoneNumberController.text.trim().isNotEmpty &&
              _phoneNumberErrorText == null);
    });
  }

  // 비밀번호 정규식
  final RegExp _regExpPw =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
  // 전화번호 정규식
  final RegExp _regExpPhoneNumber = RegExp(
      r'^(02|0[3-9][0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$|^(02|0[3-9][0-9]{1,2})[0-9]{7,8}$|^01[0-9]{9}$|^070-[0-9]{4}-[0-9]{4}$|^070[0-9]{8}$');

  final TextEditingController _pwController = TextEditingController();
  String? _pwErrorText;
  final TextEditingController _pwAuthController = TextEditingController();
  String? _pwAuthErrorText;
  final TextEditingController _nameController = TextEditingController();
  String? _nameErrorText;
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _phoneNumberErrorText;

  void _validatePw(String value) {
    if (value.isEmpty) {
      setState(() {
        _pwErrorText = '비밀번호를 입력하세요!';
      });
    } else if (!_regExpPw.hasMatch(value)) {
      setState(() {
        _pwErrorText = '영대소문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _pwErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _validatePwAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _pwAuthErrorText = '비밀번호 확인을 입력하세요!';
      });
    } else if (value != _pwController.text) {
      setState(() {
        _pwAuthErrorText = '비밀번호와 같지 않습니다!';
      });
    } else {
      setState(() {
        _pwAuthErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _validateName(String value) {
    if (value.isEmpty) {
      setState(() {
        _nameErrorText = '이름(실명)을 입력하세요.';
      });
    } else {
      setState(() {
        _nameErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _validatePhoneNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _phoneNumberErrorText = '전화번호를 입력하세요.';
      });
    } else if (!_regExpPhoneNumber.hasMatch(value)) {
      setState(() {
        _phoneNumberErrorText = "전화번호 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _phoneNumberErrorText = null;
      });
      _onCheckUserData();
    }
  }

  // 사용자 정보 수정하기 API 호출
  void _onUpdateUserData() async {
    context.goNamed(StudentNavigationScreen.routeName);
  }

  @override
  void dispose() {
    _pwController.dispose();
    _pwAuthController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내정보 변경"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: BottomButton(
          onPressed: _isSubmitted ? _onUpdateUserData : null,
          text: "수정하기",
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
                  TextFormField(
                    controller: _pwController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      errorText: _pwErrorText,
                      labelStyle: TextStyle(
                        color: _pwErrorText == null ? Colors.black : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: _onChangeBarrier,
                    onChanged: _validatePw,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckUserData();
                    },
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: _pwAuthController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호 확인',
                      errorText: _pwAuthErrorText,
                      labelStyle: TextStyle(
                        color: _pwAuthErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_person_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: _onChangeBarrier,
                    onChanged: _validatePwAuth,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckUserData();
                    },
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: '이름(실명)',
                      errorText: _nameErrorText,
                      labelStyle: TextStyle(
                        color:
                            _nameErrorText == null ? Colors.black : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.badge_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: _onChangeBarrier,
                    onChanged: _validateName,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckUserData();
                    },
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '전화번호',
                      errorText: _phoneNumberErrorText,
                      labelStyle: TextStyle(
                        color: _phoneNumberErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.phone_iphone_rounded,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: _onChangeBarrier,
                    onChanged: _validatePhoneNumber,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckUserData();
                    },
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
                  _onCheckUserData();
                });
              },
            ),
        ],
      ),
    );
  }
}
