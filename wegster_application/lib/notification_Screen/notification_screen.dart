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

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<dynamic> notificationSend(String email, String message) async {
      Map<String, String> body = {"email": email, "message": message};
      var url = Uri.parse("$baseUrl/user/send-email-notification/");
      var res = await http.post(url, body: body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: DMColors.lightGreenColor,
            content: Text(
              "Notification Send",
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: DMColors.marronColor,
            content: Text(
              "Invalid Email Address , Notification Send Failed",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'ProximaNova',
                  color: DMColors.loginColor),
              textAlign: TextAlign.center,
            )));
        print(res.body);
        print(res.statusCode);
      }
    }

    TextEditingController UserEmail = new TextEditingController();
    TextEditingController NotificationMessage = new TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LabelText(
                  name: 'Send Notification',
                  color: DMColors.blackColor,
                  size: 25,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'ProximaNova',
                  textDecoration: TextDecoration.none),
              Lottie.asset('assets/image/lottie/Token.json',
                  height: 275, width: 280),
              // const SizedBox(
              //   height: 10,
              // ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  controller: UserEmail,
                  validator: FieldValidate.valueToken,
                  decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    labelText: 'Enter Email',
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

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  controller: NotificationMessage,
                  validator: FieldValidate.valueToken,
                  decoration: InputDecoration(
                    hintText: "Enter Notification",
                    labelText: 'Enter Notification',
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
                  await notificationSend(
                      UserEmail.text, NotificationMessage.text);
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
