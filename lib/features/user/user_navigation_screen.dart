import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_have_a_meal/constants/sizes.dart';
import 'package:front_have_a_meal/features/user/widgets/nav_tab.dart';

class UserNavigationScreenArgs {
  UserNavigationScreenArgs({required this.selectedIndex});

  final int selectedIndex;
}

class UserNavigationScreen extends StatefulWidget {
  static const routeName = "navigation";
  static const routeURL = "/navigation";
  const UserNavigationScreen({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  State<UserNavigationScreen> createState() => _UserNavigationScreenState();
}

class _UserNavigationScreenState extends State<UserNavigationScreen> {
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

    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
            Offstage(
              offstage: selectedIndex != 0,
              child: const Scaffold(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavTab(
                  text: "가게",
                  isSelected: selectedIndex == 0,
                  unSelectedIcon: FontAwesomeIcons.store,
                  selectedIcon: FontAwesomeIcons.store,
                  onTap: () => _onTap(0),
                  selectedIndex: selectedIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
