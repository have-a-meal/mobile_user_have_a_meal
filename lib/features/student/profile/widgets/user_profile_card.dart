import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_have_a_meal/features/student/profile/student_Inform_update_screen.dart';
import 'package:front_have_a_meal/features/student/profile/student_setting_screen.dart';
import 'package:front_have_a_meal/providers/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({
    super.key,
  });

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  // void _showEditDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       String editedUserDef = widget.userData?.userDef ?? '';

  //       return AlertDialog(
  //         title: Text("상태 메시지"),
  //         content: TextField(
  //           onChanged: (newValue) {
  //             editedUserDef = newValue;
  //           },
  //           controller: TextEditingController(text: editedUserDef),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(dialogContext);
  //             },
  //             child: Text("취소"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               _onUpdateDef(userData!.userId, _DefController.text);
  //             },
  //             child: Text("저장"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(StudentInfromUpdateScreen.routeName);
      },
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.blue.shade400,
        child: const FaIcon(
          FontAwesomeIcons.solidCircleUser,
          size: 45,
          color: Colors.white,
        ),
      ),
      title: const Text(
        // context.watch<UserProvider>().userData!.userId,
        "유저이름",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: 40,
      ),
    );
  }
}
