import 'package:flutter/material.dart';
import 'package:front_have_a_meal/features/student/pay_check/pay_check_screen.dart';
import 'package:front_have_a_meal/features/student/profile/setting_screen.dart';
import 'package:front_have_a_meal/features/student/pay_check/ticket_refund_screen.dart';
import 'package:front_have_a_meal/features/student/profile/widgets/profile_button.dart';
import 'package:front_have_a_meal/features/student/profile/widgets/user_profile_card.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                const UserProfileCard(),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileButton(
                      onPressed: () {
                        context.pushNamed(PayCheckScreen.routeName);
                      },
                      icon: Icons.playlist_play_rounded,
                      text: "결제 내역",
                    ),
                    ProfileButton(
                      onPressed: () {
                        context.pushNamed(TicketRefundScreen.routeName);
                      },
                      icon: Icons.attach_money,
                      text: "식권 환불",
                    ),
                    ProfileButton(
                      onPressed: () {
                        context.pushNamed(SettingScreen.routeName);
                      },
                      icon: Icons.settings_outlined,
                      text: "설정",
                    ),
                    // ProfileButton(
                    //   icon: Icons.data_exploration_outlined,
                    //   text: "가격 통계",
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
