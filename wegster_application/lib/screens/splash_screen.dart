// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, unnecessary_overrides

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/screens/button_navigation.dart';
import 'package:wegster_application/screens/home_page.dart';
import 'package:wegster_application/screens/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  //late AnimationController _controller;
  String splashScreenKey = 'issplashScreenShown';

  @override
  void initState() {
    super.initState();
    //_controller = AnimationController(

    navigateToHome();
  }

  void navigateToHome() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(
      splashScreenKey,
      true,
    );

    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ButtonNavigation(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMColors.logoColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 58),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/image/lopi.svg",
                  color: DMColors.backgroundwhiteColor,
                  //height: 60,
                  width: 70,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: LabelText(
                      name: 'Wegster',
                      color: DMColors.loginColor,
                      size: 35.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                ),
              ],
            ),
            Lottie.asset('assets/image/lottie/loading.json',
                height: 350, width: 400),
            const SizedBox(height: 240),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 115),
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      color: DMColors.backgroundwhiteColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 95),
                  child: LabelText(
                      name: 'Loading Best Deals',
                      color: DMColors.loginColor,
                      size: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
