import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:towner_final_round/res/light_theme.dart';
import 'package:towner_final_round/view/main_page.dart';
import 'package:towner_final_round/data/firebase_options.dart';
import 'package:towner_final_round/viewmodel/add_notes_controller.dart';
import 'package:towner_final_round/viewmodel/auth_controller.dart';
import 'package:towner_final_round/viewmodel/home_controller.dart';
import 'package:towner_final_round/viewmodel/login_controller.dart';
import 'package:towner_final_round/viewmodel/signup_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(
          create: (_) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddScreenController(),
        )
      ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: const MainPage(),
      ),
    );
  }
}
