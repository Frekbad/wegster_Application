// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/screens/log_in_screen.dart';
import 'package:wegster_application/themes/dm_color_theme.dart';
import 'package:wegster_application/validator/validator.dart';
import 'package:wegster_application/widgets/text_widget.dart';
import 'package:http/http.dart' as http;
import '../widgets/constants.dart';

class VerifyEmailConfirmation extends StatelessWidget {
  const VerifyEmailConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    Future<dynamic> userConfirm(String key) async {
      Map<String, String> body = {"key": key};
      var url = Uri.parse("$baseUrl/user/auth/confirm-email/");
      var res = await http.post(url, body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: DMColors.lightGreenColor,
            content: Text(
              "Registration Successful",
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
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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

    TextEditingController UserKey = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const LabelText(
                name: 'Token Verification',
                color: DMColors.blackColor,
                size: 25,
                fontWeight: FontWeight.w800,
                fontFamily: 'ProximaNova',
                textDecoration: TextDecoration.none),
            Lottie.asset('assets/image/lottie/Email.json',
                height: 275, width: 280),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextFormField(
                controller: UserKey,
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
              height: 10,
            ),

            GestureDetector(
              onTap: () async {
                await userConfirm(UserKey.text);
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
                          offset:
                              const Offset(0, 4), // changes position of shadow
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
    );
  }
}
