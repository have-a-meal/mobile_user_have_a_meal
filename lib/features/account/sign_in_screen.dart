import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/features/account/sign_up_screen.dart';
import 'package:front_have_a_meal/features/student/student_navigation_screen.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "signIn";
  static const routeURL = "/";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _idController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _pwFocusNode = FocusNode();

  bool _rememberMe = false;
  bool _isSubmitted = true;

  final RegExp _idRegExp = RegExp(r'^[a-zA-Z0-9]+$'); // 아이디 정규식
  // 비밀번호 정규식
  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

  String? _idErrorText; // 아이디 오류 메시지
  String? _passwordErrorText; // 비밀번호 오류 메시지

  void _validateId(String value) {
    if (value.isEmpty) {
      setState(() {
        _idErrorText = '아이디를 입력하세요.';
      });
    } else if (!_idRegExp.hasMatch(value)) {
      setState(() {
        _idErrorText = '영문과 숫자만 입력하세요.';
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

  void _handleLogin() async {
    // final url = Uri.parse("${HttpIp.httpIp}/marine/users/auth");
    // final headers = {'Content-Type': 'application/json'};
    // final data = {
    //   'userId': _idController.text.trim(),
    //   'password': _passwordController.text.trim(),
    // };
    // final response =
    //     await http.post(url, headers: headers, body: jsonEncode(data));

    // if (response.statusCode >= 200 && response.statusCode < 300) {

    // } else {
    //   if (!mounted) return;
    //   HttpIp.errorPrint(
    //     context: context,
    //     title: "통신 오류",
    //     message: response.body,
    //   );
    // }
    context.replaceNamed(StudentNavigationScreen.routeName);
  }

  Future<void> _onTapSignUp() async {
    await context.pushNamed(SignUpScreen.routeName);
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
                flex: 3,
                child: Column(
                  children: [
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.grey.shade600,
                              ),
                              labelText: '아이디',
                              errorText: _idErrorText, // 아이디 오류 메시지 표시
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 2.0),
                              ),
                              // 텍스트 필드가 포커스를 받았을 때의 테두리 색상
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 2.0),
                              ),
                            ),
                            onChanged: _validateId, // 입력 값이 변경될 때마다 검증
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
                              // 텍스트 필드가 포커스를 받지 않았을 때의 테두리 색상
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 2.0),
                              ),
                              // 텍스트 필드가 포커스를 받았을 때의 테두리 색상
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 2.0),
                              ),
                            ),
                            onChanged: _validatePassword, // 입력 값이 변경될 때마다 검증
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                activeColor: Colors.orange,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                              ),
                              const Text('로그인 정보 저장'),
                            ],
                          ),
                          const Gap(10),
                          ElevatedButton(
                            style: const ButtonStyle(),
                            onPressed:
                                _isSubmitted ? () => _handleLogin() : null,
                            child: const Text('로그인'),
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
