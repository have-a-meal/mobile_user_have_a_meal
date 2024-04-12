import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/widgets/id_search.dart';
import 'package:front_have_a_meal/features/account/widgets/pw_search.dart';

class IdPwSearchScreen extends StatefulWidget {
  static const routeName = "id_pw_search";
  static const routeURL = "/id_pw_search";
  const IdPwSearchScreen({super.key});

  @override
  State<IdPwSearchScreen> createState() => _IdPwSearchScreenState();
}

class _IdPwSearchScreenState extends State<IdPwSearchScreen> {
  int selectedIndex = 0;

  void _onTap(int index) {
    if (selectedIndex == index) return;
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("아이디 / 비밀번호 찾기"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: selectedIndex == 0
                            ? Colors.orange.shade100
                            : Colors.white.withOpacity(0.6),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _onTap(0);
                      },
                      child: const Text(
                        "아이디 찾기",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        backgroundColor: selectedIndex == 1
                            ? Colors.orange.shade100
                            : Colors.white.withOpacity(0.6),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _onTap(1);
                      },
                      child: const Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
                  Offstage(
                    offstage: selectedIndex != 0,
                    child: const IdSearch(),
                  ),
                  Offstage(
                    offstage: selectedIndex != 1,
                    child: const PwSearch(),
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
