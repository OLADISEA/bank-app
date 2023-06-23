import 'package:bank_app/Screens/home_page.dart';
import 'package:bank_app/Screens/log_in_page.dart';
import 'package:bank_app/Screens/send_money.dart';
import 'package:bank_app/Screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/loading.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        initialRoute: '/',
        routes: {
          '/': (context) => Loadpage(),

          '/login': (context) => const LoginPage(),
          '/home': (context) =>  const HomePage(),
          '/sign up': (context) =>  SignUp(),

        }
    );
  }
}

