import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/student/menu/widgets/menu_card.dart';
import 'package:front_have_a_meal/features/student/menu/widgets/menu_course.dart';
import 'package:front_have_a_meal/features/student/menu/widgets/menu_time.dart';
import 'package:front_have_a_meal/models/menu_model.dart';
import 'package:gap/gap.dart';

class StudentMenu extends StatefulWidget {
  const StudentMenu({super.key});

  @override
  State<StudentMenu> createState() => _StudentMenuState();
}

class _StudentMenuState extends State<StudentMenu> {
  Map<String, Map<String, List<MenuModel>>> _menuMap = {
    "조식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
    "중식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
    "석식": {
      "A코스": [],
      "B코스": [],
      "C코스": [],
    },
  };

  bool _isFirstLoading = false;
  // 현재 날짜를 저장할 변수
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _initMenu();
  }

  Future<void> _initMenu() async {
    setState(() {
      _isFirstLoading = true;
    });

    // final url = Uri.parse("${HttpIp.httpIp}/marine/stores");
    // final headers = {'Content-Type': 'application/json'};
    // final response = await http.get(url, headers: headers);

    // if (response.statusCode >= 200 && response.statusCode < 300) {
    //   print("가게 리스트 호출 : 성공");
    //   final jsonResponse = jsonDecode(response.body) as List<dynamic>;

    //   setState(() {
    //     _storeList =
    //         jsonResponse.map((data) => StoreModel.fromJson(data)).toList();
    //   });
    // } else {
    //   if (!mounted) return;
    //   HttpIp.errorPrint(
    //     context: context,
    //     title: "통신 오류",
    //     message: response.body,
    //   );
    // }

    _menuMap["조식"]!["A코스"]!
        .add(MenuModel(menuId: "1", title: "조식 A코스 메뉴1", content: "조식 A코스 설명"));
    _menuMap["조식"]!["B코스"]!
        .add(MenuModel(menuId: "1", title: "조식 B코스 메뉴1", content: "조식 B코스 설명"));
    _menuMap["조식"]!["C코스"]!
        .add(MenuModel(menuId: "1", title: "조식 C코스 메뉴1", content: "조식 C코스 설명"));
    _menuMap["중식"]!["A코스"]!
        .add(MenuModel(menuId: "2", title: "중식 A코스 메뉴1", content: "중식 A코스 설명"));
    _menuMap["중식"]!["B코스"]!
        .add(MenuModel(menuId: "2", title: "중식 B코스 메뉴1", content: "중식 B코스 설명"));
    _menuMap["중식"]!["C코스"]!
        .add(MenuModel(menuId: "2", title: "중식 C코스 메뉴1", content: "중식 C코스 설명"));
    _menuMap["석식"]!["A코스"]!
        .add(MenuModel(menuId: "3", title: "석식 A코스 메뉴1", content: "석식 A코스 설명"));
    _menuMap["석식"]!["B코스"]!
        .add(MenuModel(menuId: "3", title: "석식 B코스 메뉴1", content: "석식 B코스 설명"));
    _menuMap["석식"]!["C코스"]!
        .add(MenuModel(menuId: "3", title: "석식 C코스 메뉴1", content: "석식 C코스 설명"));

    setState(() {
      _isFirstLoading = false;
    });
  }

  // 날짜 선택기를 띄우고 사용자가 날짜를 선택하면 해당 날짜로 변수를 업데이트하는 함수
  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year, now.month, now.day); // 오늘 날짜
    int daysUntilNextSunday = 7 - now.weekday + 7; // 현재 요일로부터 다음 주 일요일까지의 일수
    final DateTime lastDate = DateTime(
        now.year, now.month, now.day + daysUntilNextSunday); // 선택 가능한 늦은 날짜

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // 초기 선택 날짜
      firstDate: firstDate, // 선택 가능한 가장 이른 날짜
      lastDate: lastDate, // 선택 가능한 가장 늦은 날짜
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isFirstLoading = true;
    });

    _selectedDate = DateTime.now();
    _menuMap = {
      "조식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
      "중식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
      "석식": {
        "A코스": [],
        "B코스": [],
        "C코스": [],
      },
    };

    _initMenu();

    setState(() {
      _isFirstLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Have-A-Meal",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            sliver: SliverAppBar(
              pinned: true,
              backgroundColor: Colors.orange.shade100,
              title: ListTile(
                leading: const Icon(
                  Icons.calendar_month_outlined,
                  size: 32,
                ),
                title: Text(
                  '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () => _selectDate(context),
              ),
            ),
          )
        ],
        body: _isFirstLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _menuMap.entries.every((mealEntry) => mealEntry.value.entries
                    .every((courseEntry) => courseEntry.value.isEmpty))
                ? Center(
                    child: IconButton(
                      iconSize: MediaQuery.of(context).size.width / 3,
                      color: Colors.grey.shade400,
                      icon: const Icon(Icons.refresh_outlined),
                      onPressed: _onRefresh,
                    ),
                  )
                : RefreshIndicator.adaptive(
                    onRefresh: _onRefresh,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      // itemCount: 10,
                      // itemBuilder: (context, index) => MenuCard(
                      //   menuData: MenuModel(
                      //     menuId: "${index + 1}",
                      //     title: "주메뉴${index + 1}",
                      //     content: "보조메뉴들${index + 1}",
                      //   ),
                      // ),
                      children: [
                        const Gap(10),
                        MenuTime(
                          timeName: "조식",
                          time: "08:00 ~ 09:00",
                          timeColor: const Color(0xFFCAF0F8).withOpacity(0.5),
                          menuCourse: _menuMap["조식"]!,
                        ),
                        const Gap(10),
                        MenuTime(
                          timeName: "중식",
                          time: "12:00~13:30",
                          timeColor: const Color(0xFFFFD166).withOpacity(0.5),
                          menuCourse: _menuMap["중식"]!,
                        ),
                        const Gap(10),
                        MenuTime(
                          timeName: "석식",
                          time: "17:30~18:30",
                          timeColor: const Color(0xFF9B5DE5).withOpacity(0.4),
                          menuCourse: _menuMap["석식"]!,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
