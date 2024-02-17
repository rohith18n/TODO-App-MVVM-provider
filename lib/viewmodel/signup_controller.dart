// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:towner_final_round/data/auth_data.dart';
import 'package:towner_final_round/widgets/snackbar_messenger.dart';

class SignUpController extends ChangeNotifier {
  bool isPasswordVisible = false;
  final signUpKey = GlobalKey<FormState>();
  bool showLoading = false;
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

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
    focusNode3.addListener(() {
      notifyListeners();
    });
  }

  void registerUser(BuildContext context) async {
    if (signUpKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .removeCurrentSnackBar(); // Remove any existing snackbars
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: "Registering user...",
          isError: false,
        ),
      );

      String? errorMessage = await AuthenticationRemote().register(
        emailController.text,
        passwordController.text,
        passwordConfirmController.text,
      );
      onClose();

      ScaffoldMessenger.of(context)
          .removeCurrentSnackBar(); // Remove the loading snackbar

      if (errorMessage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            message: "Success",
            isError: false,
          ),
        );
        log(" Registration successful");
        // You can navigate to the next screen or perform any other action here
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
    notifyListeners();
  }
}
