// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:towner_final_round/data/auth_data.dart';
import 'package:towner_final_round/widgets/snackbar_messenger.dart';

class LoginController extends ChangeNotifier {
  bool isPasswordVisible = false;
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final loginKey = GlobalKey<FormState>();
  bool showLoading = false;

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void initFocusNodes() {
    focusNode1.addListener(() {
      notifyListeners();
    });
    focusNode2.addListener(() {
      notifyListeners();
    });
  }

  // void loginUser() async {
  //   showLoading = true;
  //   notifyListeners();
  //   String? errorMessage = await AuthenticationRemote().login(
  //     emailController.text,
  //     passwordController.text,
  //   );

  //   if (errorMessage == null) {
  //     showLoading = false;
  //     notifyListeners();

  //     // Login successful, navigate to the next screen or perform any other action
  //   } else {
  //     // Error occurred, print the error message
  //     showLoading = false;
  //     notifyListeners();
  //     log(errorMessage);
  //   }
  // }
  void loginUser(BuildContext context) async {
    if (loginKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .removeCurrentSnackBar(); // Remove any existing snackbars
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: "Logging in",
          isError: false,
        ),
      );

      String? errorMessage = await AuthenticationRemote().login(
        emailController.text,
        passwordController.text,
      );

      ScaffoldMessenger.of(context)
          .removeCurrentSnackBar(); // Remove the loading snackbar

      if (errorMessage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            message: "Success",
            isError: false,
          ),
        );
        log("--Login successful--");
        // Navigate to the next screen or perform any other action
      } else {
        // Error occurred, show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            message: errorMessage,
            isError: true,
          ),
        );
      }
    }
  }

  String? validateEmail(String value) {
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  void onClose() {
    emailController.clear();
    passwordController.clear();
  }
}
