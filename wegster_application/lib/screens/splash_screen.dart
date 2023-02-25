import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wegster_application/screens/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer(const Duration(seconds: 3), () {
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) => const OnboardingScreen(),
    //   ));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Center(
            child: Text(
          'Wegster',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}
