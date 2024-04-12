import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isClicked = false,
  });

  final bool isClicked;
  final String text;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed != null
          ? isClicked
              ? () => onPressed!()
              : () => onPressed!()
          : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor:
            text == "회원가입" ? Colors.orange.shade200 : Colors.lightBlue.shade100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Text(text),
    );
  }
}
