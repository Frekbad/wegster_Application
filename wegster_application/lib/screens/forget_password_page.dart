// ignore_for_file: use_build_context_synchronously, duplicate_ignore, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/screens/log_in_screen.dart';
import 'package:wegster_application/screens/reset_password_tokenPage.dart';
import 'package:wegster_application/screens/sign_up.dart';
import 'package:wegster_application/themes/dm_color_theme.dart';
import 'package:wegster_application/validator/validator.dart';
import 'package:wegster_application/widgets/text_widget.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController forgotemailController;
  final _logInKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    forgotemailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    forgotemailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _logInKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 90, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 7,
                        ),
                        child: SvgPicture.asset(
                          "assets/image/lopi.svg",
                          width: 70,
                        ),
                      ),
                      const LabelText(
                          name: 'Wegster',
                          color: DMColors.logoColor,
                          size: 30,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ],
                  ),
                ),
                //const SizedBox(height: 20),

                //const SizedBox(height: 30),
                Center(
                  child: Lottie.asset('assets/image/lottie/forgot.json',
                      height: 215, width: 280),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: LabelText(
                      name: 'Forgot Password?',
                      color: DMColors.googleColor2,
                      size: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                ),
                const SizedBox(
                  height: 15,
                ),
                const LabelText(
                    name: 'Email Address',
                    color: DMColors.textColor,
                    size: 17,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 43,
                  child: TextFormField(
                    validator: FieldValidate.validateEmail,
                    controller: forgotemailController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: DMColors.textColor)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    final isValidForm = _logInKey.currentState!.validate();
                    if (isValidForm) {
                      var authResult = await RequestPasswordToken(
                        forgotemailController.text,
                      );
                      if (authResult.runtimeType == String) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              alignment: Alignment.center,

                              // height: 100,
                              // width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: AlertDialog(
                                title: Text(authResult),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor:
                                                    DMColors.redColor,
                                                content: Text(
                                                  "Email Sent Failed",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'ProximaNova',
                                                      color:
                                                          DMColors.loginColor),
                                                  textAlign: TextAlign.center,
                                                )));
                                      },
                                      child: const Text('CANCEL')),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: DMColors.lightGreenColor,
                                content: Text(
                                  "Email Token Send Successfully",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'ProximaNova',
                                      color: DMColors.loginColor),
                                  textAlign: TextAlign.center,
                                )));
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return const ResetPasswordToken();
                          }),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    width: double.infinity,
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
                          name: 'Send Code',
                          color: DMColors.loginColor,
                          size: 17,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
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
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const LabelText(
                        name: 'or',
                        color: DMColors.textColor,
                        size: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.none),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserSignUp(),
                        ));
                      },
                      child: const LabelText(
                          name: 'Sign up',
                          color: DMColors.logoColor,
                          size: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
