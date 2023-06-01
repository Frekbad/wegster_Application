// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/screens/log_in_screen.dart';
import 'package:wegster_application/validator/validator.dart';
import 'package:wegster_application/widgets/constants.dart';
import 'package:http/http.dart' as http;

import '../exports/exports.dart';

class ResetPasswordToken extends StatefulWidget {
  const ResetPasswordToken({super.key});

  @override
  State<ResetPasswordToken> createState() => _ResetPasswordTokenState();
}

class _ResetPasswordTokenState extends State<ResetPasswordToken> {
  @override
  Widget build(BuildContext context) {
    Future<dynamic> resetEmailConfirm(String password, String token) async {
      Map<String, String> body = {
        "token": token,
        "password": password,
      };
      var url =
          Uri.parse("http://10.0.2.2:8000/user/auth/password-reset/confirm/");
      var res = await http.post(url, body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: DMColors.lightGreenColor,
            content: Text(
              "password Reset Successful",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'ProximaNova',
                  color: DMColors.loginColor),
              textAlign: TextAlign.center,
            )));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            //backgroundColor: Colors.red,
            content: Stack(
              //clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 75,
                  decoration: const BoxDecoration(
                    color: DMColors.redColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            LabelText(
                                name: 'Oh Sorry!',
                                color: DMColors.loginColor,
                                size: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Proxima Nova',
                                textDecoration: TextDecoration.none),
                            Spacer(),
                            LabelText(
                                name: 'Key Error',
                                color: DMColors.loginColor,
                                size: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Proxima Nova',
                                textDecoration: TextDecoration.none),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20)),
                    child: SvgPicture.asset(
                      "assets/image/bubbles.svg",
                      height: 40,
                      width: 40,
                      color: DMColors.marronColor,
                    ),
                  ),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: DMColors.transparentColor,
          ),
        );
      }
      print(res.body);
      print(res.statusCode);
    }

    TextEditingController resetKey = TextEditingController();
    TextEditingController resetPassword = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const LabelText(
                  name: 'Reset Password',
                  color: DMColors.blackColor,
                  size: 25,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'ProximaNova',
                  textDecoration: TextDecoration.none),
              const SizedBox(
                height: 20,
              ),

              // const SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Lottie.asset('assets/image/lottie/resettoken.json',
                    height: 200, width: 250),
              ),
              const SizedBox(
                height: 20,
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  controller: resetKey,
                  validator: FieldValidate.valueToken,
                  decoration: InputDecoration(
                    hintText: "Enter Your Token",
                    labelText: 'Enter Token',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: DMColors.textColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  controller: resetPassword,
                  validator: FieldValidate.valueToken,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    labelText: 'Enter Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: DMColors.textColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  await resetEmailConfirm(resetKey.text, resetPassword.text);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 55,
                    //width: double.infinity,
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
                        name: 'Confirm',
                        color: DMColors.loginColor,
                        size: 17,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
