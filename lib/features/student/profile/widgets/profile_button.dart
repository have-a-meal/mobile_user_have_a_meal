import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.color,
  });

  final Function onPressed;
  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Card(
        // alignment: Alignment.center,
        // padding: const EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //   // color: Colors.white,
        //   border: Border.all(
        //     width: 0.3,
        //     color: Colors.grey,
        //   ),
        //   borderRadius: const BorderRadius.all(
        //     Radius.circular(20),
        //   ),
        //   // boxShadow: [
        //   //   BoxShadow(
        //   //     offset: Offset(2, 2),
        //   //     color: Colors.grey,
        //   //     blurRadius: 3,
        //   //   )
        //   // ],
        // ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 38,
              ),
              const Gap(4),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
