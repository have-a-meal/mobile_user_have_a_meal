import 'package:flutter/material.dart';

class StudentInfromUpdateScreen extends StatefulWidget {
  static const routeName = "student_infrom_update";
  static const routeURL = "student_infrom_update";
  const StudentInfromUpdateScreen({super.key});

  @override
  State<StudentInfromUpdateScreen> createState() =>
      _StudentInfromUpdateScreenState();
}

class _StudentInfromUpdateScreenState extends State<StudentInfromUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 정보"),
      ),
    );
  }
}
