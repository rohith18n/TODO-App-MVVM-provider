// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:towner_final_round/res/colors.dart';
import 'package:towner_final_round/viewmodel/login_controller.dart';
import 'package:towner_final_round/viewmodel/signup_controller.dart';

Widget textField(
  TextEditingController controller,
  FocusNode focusNode,
  String typeName,
  IconData iconss,
  bool isPasswordField,
  dynamic controllerInstance,
  String? Function(String?)? validator,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: const TextStyle(fontSize: 18, color: Colors.black),
        obscureText: isPasswordField
            ? !(controllerInstance is LoginController
                ? controllerInstance.isPasswordVisible
                : controllerInstance is SignUpController
                    ? controllerInstance.isPasswordVisible
                    : false)
            : false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconss,
            color: focusNode.hasFocus ? customGreen : const Color(0xffc5c5c5),
          ),
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    controllerInstance is LoginController
                        ? (controllerInstance as LoginController)
                                .isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off
                        : controllerInstance is SignUpController
                            ? (controllerInstance as SignUpController)
                                    .isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off
                            : Icons.visibility_off,
                    color: customGreen,
                  ),
                  onPressed: () {
                    if (controllerInstance is LoginController) {
                      (controllerInstance as LoginController)
                          .togglePasswordVisibility();
                    } else if (controllerInstance is SignUpController) {
                      (controllerInstance as SignUpController)
                          .togglePasswordVisibility();
                    }
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: typeName,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xffc5c5c5),
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: customGreen,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
        ),
        validator: validator,
      ),
    ),
  );
}
