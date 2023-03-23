// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/google_sign/google_auth.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/screens/button_navigation.dart';
import 'package:wegster_application/screens/forget_password_page.dart';
import 'package:wegster_application/screens/sign_up.dart';
import 'package:wegster_application/validator/validator.dart';
import 'package:wegster_application/vendor_Screen/VbuttonNavigation.dart';
import 'package:wegster_application/vendor_Screen/hotelDashboard.dart';

import 'package:wegster_application/vendor_Screen/vendor_Registration.dart';

import '../exports/exports.dart';
import '../models/user_cubit.dart';

class VendorLogin extends StatefulWidget {
  const VendorLogin({super.key});

  @override
  State<VendorLogin> createState() => _VendorLoginState();
}

class _VendorLoginState extends State<VendorLogin> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _logInKey = GlobalKey<FormState>();
  bool isPassword = true;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DMColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _logInKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: duplicate_ignore
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/image/lopi.svg",
                        //height: 60,
                        width: 70,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: LabelText(
                            name: 'Wegster',
                            color: DMColors.logoColor,
                            size: 35.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'ProximaNova',
                            textDecoration: TextDecoration.none),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: LabelText(
                        name: 'Vendor Login ',
                        color: DMColors.googleColor2,
                        size: 24.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.none),
                  ),
                  // const SizedBox(height: 50),
                  Lottie.asset('assets/image/lottie/login.json',
                      height: 238, width: 300),
                  const LabelText(
                      name: 'Email Address',
                      color: DMColors.textColor,
                      size: 17.57,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "Enter your Vendor Email",
                      hintStyle: const TextStyle(color: DMColors.textColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: DMColors.textColor),
                      ),
                    ),
                    validator: FieldValidate.validateEmail,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const LabelText(
                      name: 'Password',
                      color: DMColors.textColor,
                      size: 17.57,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "Enter your Password",
                      hintStyle: const TextStyle(
                        color: DMColors.textColor,
                      ),
                      contentPadding: const EdgeInsets.only(left: 20, top: 8),
                      //prefixIcon: const Icon(Icons.visibility),
                      suffixIcon: isPassword
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                              child: Icon(isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: DMColors.textColor),
                      ),
                    ),
                    validator: FieldValidate.validatePassword,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const ForgetPassword(),
                      // ));
                      //GoRouter.of(context).go('/forgetpasswordPage');
                    },
                    child: const LabelText(
                        name: 'Forget Password?',
                        color: DMColors.textColor,
                        size: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      if (_logInKey.currentState!.validate()) {
                        var authResult = await userAuth(
                            emailController.text, passwordController.text);

                        if (authResult.runtimeType == String) {
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
                                                    "Login Failed",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            'ProximaNova',
                                                        color: DMColors
                                                            .loginColor),
                                                    textAlign: TextAlign.center,
                                                  )));
                                        },
                                        child: const Text('CANCEL')),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (authResult.runtimeType == User) {
                          User user = authResult;
                          if (user.is_user == 2) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Login Successfull",
                                      textAlign: TextAlign.center,
                                    )));

                            context.read<CubitUser>().emit(user);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const VButtonNavigation()));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Login Failed",
                                      textAlign: TextAlign.center,
                                    )));
                            print("No");
                          }
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.98),
                          boxShadow: [
                            BoxShadow(
                              color: DMColors.lightGreenColor.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(
                                  3, 4), // changes position of shadow
                            ),
                          ],
                          color: DMColors.logoColor),
                      alignment: Alignment.center,
                      child: const LabelText(
                          name: 'Login',
                          color: DMColors.loginColor,
                          size: 17,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LabelText(
                          name: "Don't have an Account ?",
                          color: DMColors.textColor,
                          size: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      const SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const VendorRegistration(),
                          ));
                          // GoRouter.of(context).go('/signupPage');
                        }),
                        child: const LabelText(
                            name: "Sign up",
                            color: DMColors.borderColor,
                            size: 18,
                            fontWeight: FontWeight.w400,
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
      ),
    );
  }
}
