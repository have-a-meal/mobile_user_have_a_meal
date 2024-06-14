import 'package:flutter/material.dart';
import 'package:front_have_a_meal/constants/sizes.dart';
import 'package:front_have_a_meal/widget_tools/swag_platform_dialog.dart';
import 'package:go_router/go_router.dart';

class HttpIp {
  static const apiUrl = "http://158.180.74.116:8080";

  static void errorPrint({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    swagPlatformDialog(
      context: context,
      title: title,
      body: Text(
        message,
        style: const TextStyle(
          fontSize: Sizes.size16,
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("확인"),
        ),
      ],
    );
  }
}
