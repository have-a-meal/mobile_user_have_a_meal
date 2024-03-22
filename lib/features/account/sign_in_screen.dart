import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "signIn";
  static const routeURL = "/";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
