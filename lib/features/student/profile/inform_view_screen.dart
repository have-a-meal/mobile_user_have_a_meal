import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/widgets/bottom_button.dart';
import 'package:front_have_a_meal/features/student/profile/email_auth_screen.dart';
import 'package:front_have_a_meal/models/user_model.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class InfromViewScreen extends StatefulWidget {
  static const routeName = "student_infrom";
  static const routeURL = "student_infrom";
  const InfromViewScreen({super.key});

  @override
  State<InfromViewScreen> createState() => _InfromViewScreenState();
}

class _InfromViewScreenState extends State<InfromViewScreen> {
  UserModel? _userData;

  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _initUserData();
  }

  Future<void> _initUserData() async {
    setState(() {
      _isFirstLoading = true;
    });

    // final url = Uri.parse(
    //     "${HttpIp.httpIp}/marine/users/${context.read<UserProvider>().userData!.userId}");
    // final headers = {'Content-Type': 'application/json'};
    // final response = await http.get(url, headers: headers);

    // if (response.statusCode >= 200) {
    //   print("유저 정보 호출 : 성공!");

    //   final jsonResponse = UserModel.fromJson(jsonDecode(response.body));

    //   setState(() {
    //     _userData = jsonResponse;
    //   });
    // } else {
    //   if (!mounted) return;
    //   HttpIp.errorPrint(
    //     context: context,
    //     title: "통신 오류",
    //     message: response.body,
    //   );
    // }

    setState(() {
      _isFirstLoading = false;
    });
  }

  void _onPushEmailAuthPage() {
    context.pushNamed(EmailAuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원 정보 조회"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: BottomButton(
          onPressed: _onPushEmailAuthPage,
          text: "수정",
          isClicked: true,
        ),
      ),
      body: _isFirstLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    const Gap(10),
                    TextFormField(
                      // initialValue: _userData!.userId,
                      initialValue: "00000000",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "아이디",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      // initialValue: _userData!.password,
                      initialValue: "0000000000",
                      readOnly: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "비밀번호",
                        prefixIcon: Icon(
                          Icons.lock_person_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      // initialValue: _userData!.name,
                      initialValue: "홍길동",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "이름(실명)",
                        prefixIcon: Icon(
                          Icons.badge_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      // initialValue: _userData!.phoneNumber,
                      initialValue: "010-0000-0000",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "전화번호",
                        prefixIcon: Icon(
                          Icons.phone_iphone_rounded,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
