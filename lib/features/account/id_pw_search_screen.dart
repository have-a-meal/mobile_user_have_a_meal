import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/widgets/id_search.dart';
import 'package:front_have_a_meal/features/account/widgets/pw_search.dart';

enum SearchType {
  id,
  pw,
}

class IdPwSearchScreen extends StatefulWidget {
  static const routeName = "id_pw_search";
  static const routeURL = "/id_pw_search";
  const IdPwSearchScreen({super.key});

  @override
  State<IdPwSearchScreen> createState() => _IdPwSearchScreenState();
}

class _IdPwSearchScreenState extends State<IdPwSearchScreen> {
  int _selectedIndex = 0;
  SearchType _searchType = SearchType.id;

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("아이디 / 비밀번호 찾기"),
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
                          value: SearchType.id,
                          label: Text(
                            "아이디 찾기",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ButtonSegment(
                          value: SearchType.pw,
                          label: Text(
                            "비밀번호 재설정",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      selected: <SearchType>{_searchType},
                      onSelectionChanged: (Set<SearchType> newSelection) {
                        setState(() {
                          _searchType = newSelection.first;
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
                    offstage: _searchType != SearchType.id,
                    child: const IdSearch(),
                  ),
                  Offstage(
                    offstage: _searchType != SearchType.pw,
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
