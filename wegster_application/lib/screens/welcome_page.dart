import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/screens/log_in_screen.dart';
import 'package:wegster_application/screens/sign_up.dart';
import 'package:wegster_application/vendor_Screen/vendor_Login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final LoginButton = Material(
        elevation: 7,
        borderRadius: BorderRadius.circular(15.0),
        color: DMColors.logoColor,
        child: MaterialButton(
          padding: const EdgeInsets.only(top: 17, bottom: 17),
          // ignore: prefer_const_constructors
          child: Text(
            'Go to Log in',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
            //GoRouter.of(context).go('/loginPage');
          },
        ));

    //Function variable for Register button.
    // ignore: non_constant_identifier_names
    final SignUpButton = Material(
        elevation: 7,
        borderRadius: BorderRadius.circular(15.0),
        color: DMColors.googleColor,
        child: MaterialButton(
          padding: const EdgeInsets.only(top: 17, bottom: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'No account yet?',
                style: TextStyle(color: DMColors.loginColor, fontSize: 20),
              ),
              SizedBox(
                width: 8,
              ),
              Text('Sign Up',
                  style: TextStyle(color: DMColors.loginColor, fontSize: 20))
            ],
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserSignUp(),
            ));
            //GoRouter.of(context).go('/signupPage');
          },
        ));

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            const Align(
              alignment: Alignment.center,
              child: LabelText(
                  name: 'Welcome',
                  color: DMColors.blackColor,
                  size: 32,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'ProximaNova',
                  textDecoration: TextDecoration.none),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LabelText(
                    name: 'Sign in or',
                    color: DMColors.blackColor,
                    size: 21,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none),
                SizedBox(
                  width: 10,
                ),
                LabelText(
                    name: 'Create a new account',
                    color: DMColors.logoColor,
                    size: 22,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none)
              ],
            ),

            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            Center(
              child: Lottie.asset('assets/image/lottie/welco.json',
                  height: 275, width: 280),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 70,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: LoginButton),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SignUpButton,
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 45,
            ),

            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const VendorLogin(),
                  ));
                },
                child: const LabelText(
                    name: 'Vendor Authentication',
                    color: DMColors.blackColor,
                    size: 17,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Proxima Nova',
                    textDecoration: TextDecoration.none))
          ],
        ),
      )),
    );
  }
}
