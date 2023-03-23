// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/Admin/admin_Register.dart';
import 'package:wegster_application/Admin/bus_BookingList.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/google_sign/google_auth.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/screens/button_navigation.dart';
import 'package:wegster_application/screens/forget_password_page.dart';
import 'package:wegster_application/screens/location_Displayscreen.dart';
import 'package:wegster_application/screens/sign_up.dart';
import 'package:wegster_application/validator/validator.dart';

import '../exports/exports.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
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
                        name: 'Login As Admin',
                        color: DMColors.googleColor2,
                        size: 24.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: Lottie.asset('assets/image/lottie/admin.json',
                        width: 250, height: 250),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
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
                      hintText: "Enter your Email",
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgetPassword(),
                      ));
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
                          if (user.is_user == 3) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Login Successfull",
                                      textAlign: TextAlign.center,
                                    )));

                            context.read<CubitUser>().emit(user);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const BusBookingList(),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: DMColors.marronColor,
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
                              color: DMColors.logoColor.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(
                                  0, 4), // changes position of shadow
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
                    height: 13,
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
                      GestureDetector(
                        onTap: (() {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AdminRegister(),
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

  Future signIn() async {
    try {
      final user = await GoogleSignInApi.login();

      if (user == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sign in Failed')));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => const ButtonNavigation())));
      }
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Plarform Exception Handled');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }
}
