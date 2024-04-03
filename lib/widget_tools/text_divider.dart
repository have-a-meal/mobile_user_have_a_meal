import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final double thickness;
  final double fontSize;
  final Color color;

  const TextDivider({
    super.key,
    required this.text,
    this.thickness = 1.0,
    this.fontSize = 16.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Divider(
            thickness: thickness,
            color: color,
            height: fontSize * 2,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(6),
            color: Colors.white,
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Expanded(
        //   child: Divider(
        //     thickness: thickness,
        //     color: color,
        //   ),
        // ),
      ],
    );
  }
}
