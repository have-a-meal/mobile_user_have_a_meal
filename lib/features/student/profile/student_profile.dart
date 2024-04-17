import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/account/sign_in_screen.dart';
import 'package:front_have_a_meal/features/student/profile/student_pay_check_screen.dart';
import 'package:front_have_a_meal/features/student/profile/student_setting_screen.dart';
import 'package:front_have_a_meal/features/student/profile/student_ticket_refund_screen.dart';
import 'package:front_have_a_meal/features/student/profile/widgets/profile_button.dart';
import 'package:front_have_a_meal/features/student/profile/widgets/user_profile_card.dart';
import 'package:gap/gap.dart';
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
              context.pushNamed(StudentSettingScreen.routeName);
            },
            icon: const Icon(Icons.settings_outlined),
            iconSize: 36,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            const UserProfileCard(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileButton(
                    onPressed: () {
                      context.pushNamed(StudentPayCheckScreen.routeName);
                    },
                    icon: Icons.playlist_play_rounded,
                    text: "결제 내역",
                    color: Colors.grey,
                  ),
                  ProfileButton(
                    onPressed: () {
                      context.pushNamed(StudentTicketRefundScreen.routeName);
                    },
                    icon: Icons.attach_money,
                    text: "환불하기",
                    color: Colors.grey,
                  ),
                  // ProfileButton(
                  //   icon: Icons.data_exploration_outlined,
                  //   text: "가격 통계",
                  //   color: Colors.grey,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
