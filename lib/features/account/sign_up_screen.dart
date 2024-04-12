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
  int _selectedIndex = 0;
  SignUpType _signUpType = SignUpType.student;

  void _onTap(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  // void _onCheckOutsiderData() {
  //   setState(() {
  //     _isSubmitted = true;
  //   });
  // }

  // void _onSubmit() async {}

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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Expanded(
            //         child: OutlinedButton(
            //           style: OutlinedButton.styleFrom(
            //             backgroundColor: selectedIndex == 0
            //                 ? Colors.orange.shade100
            //                 : Colors.white.withOpacity(0.6),
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(10),
            //                 bottomLeft: Radius.circular(10),
            //               ),
            //             ),
            //           ),
            //           onPressed: () {
            //             _onTap(0);
            //           },
            //           child: const Text(
            //             "학생",
            //             style: TextStyle(
            //               color: Colors.blue,
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: OutlinedButton(
            //           style: OutlinedButton.styleFrom(
            //             textStyle: const TextStyle(
            //               color: Colors.black,
            //             ),
            //             backgroundColor: selectedIndex == 1
            //                 ? Colors.orange.shade100
            //                 : Colors.white.withOpacity(0.6),
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.only(
            //                 topRight: Radius.circular(10),
            //                 bottomRight: Radius.circular(10),
            //               ),
            //             ),
            //           ),
            //           onPressed: () {
            //             _onTap(1);
            //           },
            //           child: const Text(
            //             "외부인",
            //             style: TextStyle(
            //               color: Colors.blue,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
