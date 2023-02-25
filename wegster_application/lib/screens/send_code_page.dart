import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wegster_application/screens/log_in_screen.dart';
import 'package:wegster_application/screens/sign_up.dart';
import 'package:wegster_application/themes/dm_color_theme.dart';
import 'package:wegster_application/widgets/pattern_container.dart';
import 'package:wegster_application/widgets/text_widget.dart';

class PatternCode extends StatelessWidget {
  const PatternCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/image/lopi.svg",
                      width: 70,
                    ),
                    const LabelText(
                        name: 'Wegster',
                        color: DMColors.logoColor,
                        size: 30,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.none)
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                  child: LabelText(
                      name: 'Enter Code',
                      color: DMColors.textColor,
                      size: 40,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none)),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  PatternContainer(
                    height: 56,
                    width: 45,
                    keyboardType: TextInputType.number,
                  ),
                  // SizedBox(width: 2),
                  PatternContainer(
                    height: 56,
                    width: 45,
                    keyboardType: TextInputType.number,
                  ),
                  PatternContainer(
                    height: 56,
                    width: 45,
                    keyboardType: TextInputType.number,
                  ),
                  PatternContainer(
                    height: 56,
                    width: 45,
                    keyboardType: TextInputType.number,
                  ),
                  PatternContainer(
                    height: 56,
                    width: 45,
                    keyboardType: TextInputType.number,
                  ),
                  PatternContainer(
                    height: 56,
                    width: 45,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 20),
              Ink(
                child: InkWell(
                  splashColor: DMColors.borderColor,
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 53.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: DMColors.logoColor.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      color: DMColors.logoColor,
                    ),
                    child: const Center(
                      child: LabelText(
                          name: 'Next',
                          color: DMColors.loginColor,
                          size: 17,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                    child: const LabelText(
                        name: 'Login',
                        color: DMColors.logoColor,
                        size: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.none),
                  ),
                  const SizedBox(width: 5),
                  const LabelText(
                      name: 'or',
                      color: DMColors.textColor,
                      size: 17,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const UserSignUp(),
                          ),
                          (route) => false);
                      //GoRouter.of(context).go('/signupPage');
                    },
                    child: const LabelText(
                        name: 'Sign up',
                        color: DMColors.logoColor,
                        size: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.none),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
