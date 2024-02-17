import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towner_final_round/res/colors.dart';
import 'package:towner_final_round/viewmodel/auth_controller.dart';
import 'package:towner_final_round/viewmodel/login_controller.dart';
import 'package:towner_final_round/widgets/login_formfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final loginController = context.watch<LoginController>();
    loginController.initFocusNodes();

    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              image(),
              const SizedBox(height: 50),
              _buildTextField(context),
              const SizedBox(height: 8),
              account(() => authController.toggleScreen()),
              const SizedBox(height: 20),
              loginBottom(context, loginController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    final controller = context.watch<LoginController>();
    return Form(
      key: controller.loginKey,
      child: Column(
        children: [
          textField(
              controller.emailController,
              controller.focusNode1,
              'Email',
              Icons.email,
              false,
              controller,
              (value) => controller.validateEmail(value!)),
          const SizedBox(height: 10),
          textField(
              controller.passwordController,
              controller.focusNode2,
              'Password',
              Icons.lock_open_rounded,
              true,
              controller,
              (value) => controller.validatePassword(value!)),
        ],
      ),
    );
  }

  Widget account(void Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: onTap,
            child: const Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loginBottom(BuildContext context, LoginController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          controller.loginUser(context);
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: customGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Log In',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: backgroundColors,
          image: const DecorationImage(
            image: AssetImage('images/7.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
