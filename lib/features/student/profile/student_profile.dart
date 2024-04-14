import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/sign_in_screen.dart';
import 'package:front_have_a_meal/features/student/profile/student_ticket_refund_screen.dart';
import 'package:go_router/go_router.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("내 정보"),
          actions: [
            IconButton(
              onPressed: () {
                context.pushReplacementNamed(SignInScreen.routeName);
              },
              icon: const Icon(Icons.settings_outlined),
              iconSize: 36,
            ),
          ],
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.pushNamed(StudentTicketRefundScreen.routeName);
              },
              child: const Text("환불 하기"),
            ),
          ],
        ));
  }
}
