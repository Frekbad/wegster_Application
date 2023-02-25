import 'package:flutter/material.dart';
import 'package:wegster_application/validator/validator.dart';
import 'package:wegster_application/vendor_Screen/vendor_Login.dart';

import '../exports/exports.dart';

class VendorRegistration extends StatefulWidget {
  const VendorRegistration({super.key});

  @override
  State<VendorRegistration> createState() => _VendorRegistrationState();
}

class _VendorRegistrationState extends State<VendorRegistration> {
  late TextEditingController usernameController;
  late TextEditingController useremailController;

  late TextEditingController useraddressController;
  late TextEditingController userpasswordController;
  late TextEditingController passwordconfirmController;

  final _logInKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    useremailController = TextEditingController();

    useraddressController = TextEditingController();
    userpasswordController = TextEditingController();
    passwordconfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    useremailController.dispose();

    useraddressController.dispose();
    userpasswordController.dispose();
    passwordconfirmController.dispose();
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
                            text: 'Sign Up As Vendor ... ',
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
                  const SizedBox(height: 35),
                  SignUpContainer(
                    controller: usernameController,
                    name: 'Name',
                    prefix: const Icon(
                      Icons.person_outline_rounded,
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
                      Icons.email_rounded,
                      color: DMColors.orangeColor,
                    ),
                    validator: FieldValidate.validateEmail,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SignUpContainer(
                    controller: useraddressController,
                    name: 'Address',
                    prefix: const Icon(
                      Icons.location_on_outlined,
                      color: DMColors.redColor,
                    ),
                    validator: (address) {
                      if (address!.isEmpty) {
                        return 'Enter your address';
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
                    controller: userpasswordController,
                    name: 'Password',
                    obsecure: true,
                    prefix: const Icon(
                      Icons.fingerprint_outlined,
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
                      Icons.fingerprint_outlined,
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
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.98),
                          boxShadow: [
                            BoxShadow(
                              color: DMColors.orangeColor.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(
                                  3, 4), // changes position of shadow
                            ),
                          ],
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
                            builder: (context) => const VendorLogin(),
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
