import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/http_ip.dart';
import 'package:front_have_a_meal/features/student/profile/student_Infrom_update_screen.dart';
import 'package:front_have_a_meal/models/user_model.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class StudentInfromScreen extends StatefulWidget {
  static const routeName = "student_infrom";
  static const routeURL = "student_infrom";
  const StudentInfromScreen({super.key});

  @override
  State<StudentInfromScreen> createState() => _StudentInfromScreenState();
}

class _StudentInfromScreenState extends State<StudentInfromScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 정보 조회"),
      ),
      body: _isFirstLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
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
                        ),
                        const Gap(10),
                        ElevatedButton(
                          onPressed: () async {
                            await context.pushNamed(
                              StudentInfromUpdateScreen.routeName,
                              extra: StudentInfromUpdateScreenArgs(
                                updateType: UpdateType.pw,
                              ),
                            );

                            _initUserData();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(22),
                            textStyle: const TextStyle(fontSize: 14),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text("수정"),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
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
                        ),
                        const Gap(10),
                        ElevatedButton(
                          onPressed: () async {
                            await context.pushNamed(
                              StudentInfromUpdateScreen.routeName,
                              extra: StudentInfromUpdateScreenArgs(
                                updateType: UpdateType.name,
                              ),
                            );

                            _initUserData();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(22),
                            textStyle: const TextStyle(fontSize: 14),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text("수정"),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
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
                        ),
                        const Gap(10),
                        IntrinsicHeight(
                          child: ElevatedButton(
                            onPressed: () async {
                              await context.pushNamed(
                                StudentInfromUpdateScreen.routeName,
                                extra: StudentInfromUpdateScreenArgs(
                                  updateType: UpdateType.phoneNumber,
                                ),
                              );

                              _initUserData();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(22),
                              textStyle: const TextStyle(fontSize: 14),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text("수정"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}