import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:towner_final_round/view/login.dart';
import 'package:towner_final_round/view/sign_up.dart';
import 'package:towner_final_round/viewmodel/auth_controller.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthPageContent();
  }
}

class AuthPageContent extends StatelessWidget {
  const AuthPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    return Scaffold(
      body: authController.isLogin ? const LoginScreen() : const SignUpScreen(),
    );
  }
}
