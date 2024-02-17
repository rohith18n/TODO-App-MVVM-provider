// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:towner_final_round/widgets/snackbar_messenger.dart';

class HomeScreenProvider extends ChangeNotifier {
  bool _show = true;

  bool get show => _show;

  void setShow(bool value) {
    _show = value;
    notifyListeners();
  }

  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  void scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void signOut(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Signing out...',
          isError: false,
        ),
      );
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Signed out',
          isError: false,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Error signing out',
          isError: true,
        ),
      );
    }
  }
}
