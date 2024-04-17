import 'package:flutter/material.dart';

enum UpdateType {
  pw,
  name,
  phoneNumber,
}

class StudentInfromUpdateScreenArgs {
  final UpdateType updateType;

  StudentInfromUpdateScreenArgs({required this.updateType});
}

class StudentInfromUpdateScreen extends StatefulWidget {
  static const routeName = "student_infrom_update";
  static const routeURL = "student_infrom_update";
  const StudentInfromUpdateScreen({
    super.key,
    required this.updateType,
  });

  final UpdateType updateType;

  @override
  State<StudentInfromUpdateScreen> createState() =>
      _StudentInfromUpdateScreenState();
}

class _StudentInfromUpdateScreenState extends State<StudentInfromUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.updateType == UpdateType.pw
            ? "비밀번호 변경"
            : widget.updateType == UpdateType.name
                ? "이름 변경"
                : "전화번호 번경"),
      ),
    );
  }
}
