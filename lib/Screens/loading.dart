import 'dart:async';
import 'package:bank_app/Screens/home_view.dart';
import 'package:bank_app/Utilities/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'log_in_page.dart';

class Loadpage extends StatefulWidget {
  const Loadpage({super.key});

  @override
  State<Loadpage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Loadpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      Navigator
          .pushReplacement(context,PageTransition(type: PageTransitionType.fade,child: const HomeView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3D0175),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Dimensions.height60,
              height: Dimensions.height60,
              child: const CircularProgressIndicator(
                strokeWidth: 4,
                color: Color.fromARGB(255, 255, 0, 191),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "Loading...",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
