import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/sizes.dart';

void swagPlatformDialog({
  required BuildContext context,
  required String title,
  required String message,
  required List<Widget> actions,
}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        actions: actions,
      ),
    );
  } else if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
