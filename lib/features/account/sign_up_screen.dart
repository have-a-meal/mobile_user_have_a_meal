import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_have_a_meal/features/account/widgets/sign_up_outsider.dart';
import 'package:front_have_a_meal/features/account/widgets/sign_up_student.dart';

enum SignUpType {
  student,
  outsider,
}

class SignUpScreen extends StatefulWidget {
  static const routeName = "signUp";
  static const routeURL = "/signUp";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpType _signUpType = SignUpType.student;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("회원가입"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 16,
                    ),
                    child: SegmentedButton(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      segments: const [
                        ButtonSegment(
                          value: SignUpType.student,
                          label: Text(
                            "학생",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ButtonSegment(
                          value: SignUpType.outsider,
                          label: Text(
                            "외부인",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      selected: <SignUpType>{_signUpType},
                      onSelectionChanged: (Set<SignUpType> newSelection) {
                        setState(() {
                          _signUpType = newSelection.first;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
                  Offstage(
                    offstage: _signUpType != SignUpType.student,
                    child: const SignUpStudent(),
                  ),
                  Offstage(
                    offstage: _signUpType != SignUpType.outsider,
                    child: const SignUpOutsider(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
