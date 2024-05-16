import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/sign_in_screen.dart';
import 'package:front_have_a_meal/features/profile/inform_view_screen.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = "student_settings";
  static const routeURL = "student_settings";
  const SettingScreen({super.key});

  // 로그아웃
  Future<void> onLogoutTap(BuildContext context) async {
    // LoginStorage.resetLoginData();
    // context.pop();
    context.goNamed(SignInScreen.routeName);
    // await context.read<UserProvider>().logout();
  }

  // 계정 삭제
  Future<void> _onDeleteTap(BuildContext context) async {
    // LoginStorage.resetLoginData();
    // context.pop();
    context.goNamed(SignInScreen.routeName);
    // await context.read<UserProvider>().logout();

    // final url = Uri.parse("${HttpIp.userUrl}/together/delete");
    // final data = {
    //   "userId": "${context.read<UserProvider>().userData?.userId}",
    // };

    // final response = await http.post(url, body: data);

    // if (response.statusCode >= 200 && response.statusCode < 300) {
    //   if (!mounted) return;
    //   context.read<UserProvider>().logout();
    //   LoginStorage.resetLoginData();
    //   context.read<MainNavigationProvider>().changeIndex(0);
    //   context.pop();
    // } else {
    //   if (!mounted) return;
    //   HttpIp.errorPrint(
    //     context: context,
    //     title: "계정 삭제 실패!",
    //     message: "${response.statusCode.toString()} : ${response.body}",
    //   );
    // }
  }

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromARGB(255, 152, 152, 152),
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(title: "회원 정보 관리"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () {
                  // _userInquiryTap;
                  context.pushNamed(
                    InfromViewScreen.routeName,
                  );
                },
                title: const Text(
                  "회원 정보 조회",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                ),
              ),
            ),
            _title(title: "서비스"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const LicensePage(),
                  ),
                ),
                title: const Text(
                  "앱 정보(라이센스)",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                ),
              ),
            ),
            const Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  "이용 약관",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                ),
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () {
                  // context.pushNamed(
                  //   NoticeScreen.routeName,
                  // );
                },
                title: const Text(
                  "공지사항",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                ),
              ),
            ),
            _title(title: "계정 관리"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () => onLogoutTap(context),
                title: const Text(
                  "로그아웃",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                ),
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () => _onDeleteTap(context),
                title: const Text(
                  "회원 탈퇴",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
