import 'package:flutter/material.dart';
import 'package:front_have_a_meal/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogined = false;
  UserModel? _userData;

  bool get isLogined => _isLogined;
  UserModel? get userData => _userData;

  Future<void> login(UserModel userData) async {
    _isLogined = true;
    _userData = userData;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLogined = false;
    _userData = null;
    notifyListeners();
  }
}
