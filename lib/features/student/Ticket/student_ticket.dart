import 'package:flutter/material.dart';

class StudentTicket extends StatefulWidget {
  const StudentTicket({super.key});

  @override
  State<StudentTicket> createState() => _StudentTicketState();
}

class _StudentTicketState extends State<StudentTicket> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("티켓화면"),
      ),
    );
  }
}
