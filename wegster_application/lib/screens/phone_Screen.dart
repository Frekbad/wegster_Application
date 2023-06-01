// ignore_for_file: unnecessary_string_interpolations

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/screens/code.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  Country country = Country(
    phoneCode: "977",
    countryCode: "NP",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Nepal",
    example: "Nepal",
    displayName: "Nepal",
    displayNameNoCountryCode: "NP",
    e164Key: "",
  );

  @override
  void initState() {
    countryController.text = "+977";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    countryController.selection = TextSelection.fromPosition(
        TextPosition(offset: countryController.text.length));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DMColors.backgroundwhiteColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/number.png',
              width: 500,
              height: 350,
            ),
            const SizedBox(
              height: 35,
            ),
            const Text(
              "Phone Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 10),
              child: Center(
                child: Text(
                  "We need to register your phone without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              countryController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      countryListTheme:
                                          const CountryListThemeData(
                                              bottomSheetHeight: 600),
                                      onSelect: (value) {
                                        setState(() {
                                          country = value;
                                        });
                                      },
                                    );
                                  },
                                  child: Text(
                                    "${country.flagEmoji}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: DMColors.blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              suffixIcon: countryController.text.length > 9
                                  ? Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: DMColors.greenColor),
                                      child: const Icon(
                                        Icons.done,
                                        color: DMColors.backgroundwhiteColor,
                                        size: 20,
                                      ),
                                    )
                                  : null)),
                    ),
                    Row(
                      children: [
                        Text(
                          "+ ${country.phoneCode}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: DMColors.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "|",
                          style: TextStyle(
                              fontSize: 33, color: DMColors.googleColor2),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        phone = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Phone Number",
                      ),
                    ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: DMColors.logoColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryController.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify = verificationId;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyVerify()));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: const Text(
                      "Get OTP",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: DMColors.backgroundwhiteColor),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
