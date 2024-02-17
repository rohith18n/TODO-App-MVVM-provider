import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool isLogin = true;

  void toggleScreen() {
    isLogin = !isLogin;
    notifyListeners();
  }
}
