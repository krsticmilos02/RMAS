import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/authentication_repository/authentication_repository.dart';
import 'package:quiz_city_rmas/firebase_options.dart';
import 'package:quiz_city_rmas/login_screen/login_screen.dart';
import 'login_screen/login_screen.dart';
import 'register_screen/register_screen.dart';
import 'package:get/get.dart';
import 'screens/welcome_screen_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: WelcomeScreen(),
    );
  }
}


