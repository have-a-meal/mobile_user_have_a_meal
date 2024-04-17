import 'package:flutter/material.dart';

class StudentPayCheckScreen extends StatelessWidget {
  static const routeName = "student_pay_check";
  static const routeURL = "student_pay_check";
  const StudentPayCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("결제 내역"),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
