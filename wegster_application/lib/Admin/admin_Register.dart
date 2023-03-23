// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:wegster_application/Admin/admin_Login.dart';
import 'package:wegster_application/screens/email_verification_token.dart';
import 'package:wegster_application/validator/validator.dart';
import 'package:wegster_application/widgets/signup_container.dart';
import 'package:wegster_application/widgets/text_widget.dart';

import '../api/auth/django_authentication_api.dart';
import '../themes/theme_exports.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  late TextEditingController usernameController;
  late TextEditingController useremailController;

  late TextEditingController userpasswordController;
  late TextEditingController passwordconfirmController;

  final _logInKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    useremailController = TextEditingController();

    userpasswordController = TextEditingController();
    passwordconfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    useremailController.dispose();

    userpasswordController.dispose();
    passwordconfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bool passwordVisible = false;
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                color: Colors.blue), //apply style to all
                            children: [
                          TextSpan(
                            text: 'Sign Up ... ',
                            style: TextStyle(
                              color: DMColors.googleColor2,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'ProximaNova',
                              decoration: TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                              text: 'Now!',
                              style: TextStyle(
                                color: DMColors.logoColor,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ProximaNova',
                                decoration: TextDecoration.none,
                              )),
                        ])),
                  ),
                  const SizedBox(height: 30),
                  SignUpContainer(
                    controller: usernameController,
                    name: 'Name',
                    prefix: const Icon(
                      Icons.person_rounded,
                      color: DMColors.logoColor,
                    ),
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Enter your name';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    obsecure: false,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SignUpContainer(
                    controller: useremailController,
                    name: 'Email',
                    prefix: const Icon(
                      Icons.email_sharp,
                      color: DMColors.orangeColor,
                    ),
                    validator: FieldValidate.validateEmail,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  const SizedBox(
                    height: 35,
                  ),
                  SignUpContainer(
                    controller: userpasswordController,
                    name: 'Password',
                    obsecure: true,
                    prefix: const Icon(
                      Icons.lock_outlined,
                      color: DMColors.pinkredColor,
                    ),
                    suffix: const Icon(Icons.remove_red_eye_outlined),
                    validator: FieldValidate.validatePassword,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SignUpContainer(
                    controller: passwordconfirmController,
                    name: 'Confirm Password',
                    obsecure: true,
                    prefix: const Icon(
                      Icons.lock_outline,
                      color: DMColors.pinkredColor,
                    ),
                    suffix: const Icon(Icons.remove_red_eye_outlined),
                    validator: FieldValidate.validatePassword,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  InkWell(
                    onTap: () async {
                      final isValidForm = _logInKey.currentState!.validate();
                      if (isValidForm) {
                        var authResult = await registerAdmin(
                          useremailController.text,
                          userpasswordController.text,
                          passwordconfirmController.text,
                          usernameController.text,
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
                                                    "Registration Failed",
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
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: DMColors.lightGreenColor,
                                  content: Text(
                                    "Token Send Successfully",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'ProximaNova',
                                        color: DMColors.loginColor),
                                    textAlign: TextAlign.center,
                                  )));
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const VerifyEmailConfirmation();
                            }),
                          );
                        }
                      }
                      // GoRouter.of(context).go('/homePage');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.98),
                          color: DMColors.logoColor),
                      alignment: Alignment.center,
                      child: const LabelText(
                          name: 'Signup',
                          color: DMColors.loginColor,
                          size: 17,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LabelText(
                          name: "Already have an Account ?",
                          color: DMColors.textColor,
                          size: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AdminLogin(),
                          ));
                          //GoRouter.of(context).go('/');
                        },
                        child: const LabelText(
                            name: "Login",
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
