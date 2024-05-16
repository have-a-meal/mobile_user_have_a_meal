import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.color,
  });

  final Function onPressed;
  final IconData icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 4,
      height: width / 4,
      child: Card(
        color: color,
        child: InkWell(
          onTap: () => onPressed(),
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      ),
    );
  }
}
