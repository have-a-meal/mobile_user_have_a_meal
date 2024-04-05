import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_have_a_meal/constants/sizes.dart';
import 'package:front_have_a_meal/features/outsider/menu/outsider_menu.dart';
import 'package:front_have_a_meal/features/outsider/ticket/outsider_ticket.dart';
import 'package:front_have_a_meal/features/student/widgets/nav_tab.dart';

class OutsiderNavigationScreenArgs {
  OutsiderNavigationScreenArgs({required this.selectedIndex});

  final int selectedIndex;
}

class OutsiderNavigationScreen extends StatefulWidget {
  static const routeName = "outsider_navigation";
  static const routeURL = "/outsider_navigation";
  const OutsiderNavigationScreen({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  State<OutsiderNavigationScreen> createState() =>
      _OutsiderNavigationScreenState();
}

class _OutsiderNavigationScreenState extends State<OutsiderNavigationScreen> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
          Offstage(
            offstage: selectedIndex != 0,
            child: const OutsiderMenu(),
          ),
          Offstage(
            offstage: selectedIndex != 1,
            child: const OutsiderTicket(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "메뉴",
                isSelected: selectedIndex == 0,
                unSelectedIcon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: selectedIndex,
              ),
              NavTab(
                text: "식권",
                isSelected: selectedIndex == 1,
                unSelectedIcon: FontAwesomeIcons.ticket,
                selectedIcon: FontAwesomeIcons.ticket,
                onTap: () => _onTap(1),
                selectedIndex: selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
