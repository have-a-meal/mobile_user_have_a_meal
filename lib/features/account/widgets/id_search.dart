import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/widgets/bottom_button.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class IdSearch extends StatefulWidget {
  const IdSearch({super.key});

  @override
  State<IdSearch> createState() => _IdSearchState();
}

class _IdSearchState extends State<IdSearch> {
  bool _isSubmitted = false;
  bool _isBarrier = false;

  void _onCheckSearchData() {
    setState(() {
      _isSubmitted = (_searchNameController.text.trim().isNotEmpty &&
              _searchNameErrorText == null) &&
          (_searchPhoneNumberController.text.trim().isNotEmpty &&
              _searchPhoneNumberErrorText == null);
    });
  }

  void onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  // ID 찾기 API
  void _onSearchId() async {
    swagPlatformDialog(
      context: context,
      title: "ID 확인",
      message: "당신의 아이디는 00000000 입니다!",
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("취소"),
        ),
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("확인"),
        ),
      ],
    );
  }

  // 전화번호 정규식
  final RegExp _regExpPhoneNumber = RegExp(
      r'^(02|0[3-9][0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$|^(02|0[3-9][0-9]{1,2})[0-9]{7,8}$|^01[0-9]{9}$|^070-[0-9]{4}-[0-9]{4}$|^070[0-9]{8}$');

  final TextEditingController _searchNameController = TextEditingController();
  String? _searchNameErrorText;
  final TextEditingController _searchPhoneNumberController =
      TextEditingController();
  String? _searchPhoneNumberErrorText;

  void _validateSearchName(String value) {
    if (value.isEmpty) {
      setState(() {
        _searchNameErrorText = '이름(실명)을 입력하세요.';
      });
    } else {
      setState(() {
        _searchNameErrorText = null;
      });
      _onCheckSearchData();
    }
  }

  void _validateSearchPhoneNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _searchPhoneNumberErrorText = '전화번호를 입력하세요.';
      });
    } else if (!_regExpPhoneNumber.hasMatch(value)) {
      setState(() {
        _searchPhoneNumberErrorText = "전화번호 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _searchPhoneNumberErrorText = null;
      });
      _onCheckSearchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: BottomButton(
          onPressed: _isSubmitted ? _onSearchId : null,
          text: "아이디 찾기",
          isClicked: _isSubmitted,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(10),
                  TextFormField(
                    controller: _searchNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: '이름(실명)',
                      errorText: _searchNameErrorText,
                      labelStyle: TextStyle(
                        color: _searchNameErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.badge_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: onChangeBarrier,
                    onChanged: _validateSearchName,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckSearchData();
                    },
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: _searchPhoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '전화번호',
                      errorText: _searchPhoneNumberErrorText,
                      labelStyle: TextStyle(
                        color: _searchPhoneNumberErrorText == null
                            ? Colors.black
                            : Colors.red,
                      ),
                      prefixIcon: Icon(
                        Icons.phone_iphone_rounded,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onTap: onChangeBarrier,
                    onChanged: _validateSearchPhoneNumber,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _onCheckSearchData();
                    },
                  ),
                ],
              ),
            ),
            if (_isBarrier)
              ModalBarrier(
                // color: _barrierAnimation,
                color: Colors.transparent,
                // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
                dismissible: true,
                // 자신을 클릭하면 실행되는 함수
                onDismiss: () {
                  setState(() {
                    _isBarrier = false;
                    FocusScope.of(context).unfocus();
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
