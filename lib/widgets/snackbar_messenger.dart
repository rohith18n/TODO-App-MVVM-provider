import 'package:flutter/material.dart';

SnackBar customSnackBar({
  required String message,
  required bool isError,
  String? title,
}) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    action: SnackBarAction(
      label: 'Close',
      textColor: Colors.white,
      onPressed: () {},
    ),
  );
}
