import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/features/account/pw_reset_auth_screen.dart';
import 'package:front_have_a_meal/features/account/sign_up_screen.dart';
import 'package:front_have_a_meal/features/navigation_screen.dart';
import 'package:front_have_a_meal/models/user_model.dart';
import 'package:front_have_a_meal/providers/user_provider.dart';
import 'package:front_have_a_meal/storages/login_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

enum LoginType {
  student,
  outsider,
}

class SignInScreen extends StatefulWidget {
  static const routeName = "signIn";
  static const routeURL = "/";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _idController =
      TextEditingController(text: "22471026");
  final FocusNode _idFocusNode = FocusNode();
  final TextEditingController _passwordController =
      TextEditingController(text: "Test@1234");
  final FocusNode _pwFocusNode = FocusNode();

  bool _rememberMe = false;
  final bool _simpleLogin = false;
  bool _isSubmitted = true;
  LoginType _loginType = LoginType.student;

  // 학번 정규식
  final RegExp _idRegExp = RegExp(r'^\d{8}$');
  // 전화번호 정규식
  final RegExp _regExpPhoneNumber = RegExp(
      r'^(02|0[3-9][0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$|^(02|0[3-9][0-9]{1,2})[0-9]{7,8}$|^01[0-9]{9}$|^070-[0-9]{4}-[0-9]{4}$|^070[0-9]{8}$');
  // 비밀번호 정규식
  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

  String? _idErrorText; // 아이디 오류 메시지
  String? _passwordErrorText; // 비밀번호 오류 메시지

  void _validateIdStudentNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _idErrorText = '아이디를 입력하세요.';
      });
    } else if (!_idRegExp.hasMatch(value)) {
      setState(() {
        _idErrorText = '8자리 숫자를 입력하세요.';
      });
    } else {
      setState(() {
        _idErrorText = null; // 오류가 없을 경우 null로 설정
      });
      _checkSubmitted();
    }
  }

  void _validateIdEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _idErrorText = '전화번호를 입력하세요.';
      });
    } else if (!_regExpPhoneNumber.hasMatch(value)) {
      setState(() {
        _idErrorText = '전화번호 규칙에 맞게 입력하세요.';
      });
    } else {
      setState(() {
        _idErrorText = null; // 오류가 없을 경우 null로 설정
      });
      _checkSubmitted();
    }
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordErrorText = '비밀번호를 입력하세요.';
      });
    } else if (!_passwordRegExp.hasMatch(value)) {
      setState(() {
        _passwordErrorText = '영문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _passwordErrorText = null; // 오류가 없을 경우 null로 설정
      });
      _checkSubmitted();
    }
  }

  void _checkSubmitted() {
    setState(() {
      _isSubmitted = _idErrorText == null && _passwordErrorText == null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _onCheckAutoLogin() {}

  void _handleLogin() async {
    final url = Uri.parse("${HttpIp.apiUrl}/members/login");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'memberId': _idController.text.trim(),
      'password': _passwordController.text.trim(),
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final userData = UserModel.fromJson(jsonResponse);

      if (_rememberMe) {
        await LoginStorage.saveLoginData(
          id: userData.memberId,
          pw: _passwordController.text.trim(),
          isStudent: userData.memberType,
        );
      }

      if (!mounted) return;
      await context.read<UserProvider>().login(userData);
      if (!mounted) return;
      context.replaceNamed(NavigationScreen.routeName);
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }
  }

  Future<void> _onTapSignUp() async {
    await context.pushNamed(SignUpScreen.routeName);
  }

  Future<void> _onTapSearch() async {
    await context.pushNamed(PwResetAuthScreen.routeName);
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _idFocusNode.dispose();
    _pwFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _idFocusNode.unfocus();
        _pwFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
          color: Colors.orange.shade200,
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "계정이 없으신가요? ",
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: _onTapSignUp,
                child: const Text(
                  " 회원가입",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.shade200,
                Colors.white,
                Colors.white,
                Colors.orange.shade200,
              ], // 시작과 끝 색상 지정
            ),
          ),
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Have-A-Meal",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    const Text(
                      "로그인 유형",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Gap(6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: SegmentedButton(
                              showSelectedIcon: false,
                              style: const ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              segments: const [
                                ButtonSegment(
                                  value: LoginType.student,
                                  label: Text("학생"),
                                ),
                                ButtonSegment(
                                  value: LoginType.outsider,
                                  label: Text("외부인"),
                                ),
                              ],
                              selected: <LoginType>{_loginType},
                              onSelectionChanged:
                                  (Set<LoginType> newSelection) {
                                setState(() {
                                  _idController.text = '';
                                  _passwordController.text = '';
                                  _idErrorText = null;
                                  _passwordErrorText = null;
                                  _idFocusNode.unfocus();
                                  _pwFocusNode.unfocus();
                                  _loginType = newSelection.first;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _idController,
                            focusNode: _idFocusNode,
                            autofocus: false,
                            keyboardType: _loginType == LoginType.student
                                ? TextInputType.number
                                : TextInputType.phone,
                            maxLength:
                                _loginType == LoginType.student ? 8 : 254,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                _loginType == LoginType.student
                                    ? Icons.person_outline
                                    : Icons.phone_iphone_rounded,
                                color: Colors.grey.shade600,
                              ),
                              labelText: _loginType == LoginType.student
                                  ? '학번'
                                  : '전화번호',
                              counterText: '', // 글자수 제한 표시 없애기
                              errorText: _idErrorText, // 아이디 오류 메시지 표시
                              labelStyle: TextStyle(
                                color: _idErrorText == null
                                    ? Colors.black
                                    : Colors.red,
                              ),
                            ),
                            onChanged: _loginType == LoginType.student
                                ? _validateIdStudentNumber
                                : _validateIdEmail, // 입력 값이 변경될 때마다 검증
                          ),
                          const Gap(10),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _pwFocusNode,
                            obscureText: true,
                            autofocus: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey.shade600,
                              ),
                              labelText: '비밀번호',
                              errorText: _passwordErrorText, // 비밀번호 오류 메시지 표시
                              labelStyle: TextStyle(
                                color: _passwordErrorText == null
                                    ? Colors.black
                                    : Colors.red,
                              ),
                            ),
                            onChanged: _validatePassword, // 입력 값이 변경될 때마다 검증
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox.adaptive(
                                      value: _rememberMe,
                                      activeColor: Colors.orange,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value!;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (_rememberMe) {
                                          _rememberMe = false;
                                        } else {
                                          _rememberMe = true;
                                        }
                                        setState(() {});
                                      },
                                      child: const Text('로그인 정보 저장'),
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Checkbox.adaptive(
                              //         value: _simpleLogin,
                              //         activeColor: Colors.orange,
                              //         onChanged: (value) {
                              //           setState(() {
                              //             _simpleLogin = value!;
                              //           });
                              //         },
                              //       ),
                              //       GestureDetector(
                              //         onTap: () {
                              //           if (_simpleLogin) {
                              //             _simpleLogin = false;
                              //           } else {
                              //             _simpleLogin = true;
                              //           }
                              //           setState(() {});
                              //         },
                              //         child: const Text('간편 로그인'),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          const Gap(10),
                          ElevatedButton(
                            style: const ButtonStyle(),
                            onPressed:
                                _isSubmitted ? () => _handleLogin() : null,
                            child: const Text('로그인'),
                          ),
                          InkWell(
                            onTap: _onTapSearch,
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                                right: 10,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "비밀번호 찾기",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
