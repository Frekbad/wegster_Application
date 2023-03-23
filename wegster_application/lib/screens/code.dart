// // ignore_for_file: use_build_context_synchronously
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:wegster_application/screens/phone_Screen.dart';
import 'package:wegster_application/screens/welcome_page.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var code = "";
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/img1.png',
              //   width: 150,
              //   height: 150,
              // ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: MyPhone.verify, smsCode: code);
                        await auth.signInWithCredential(credential);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ));
                      } catch (e) {
                        print("Invalid Code");
                      }
                    },
                    child: Text("Verify Phone Number")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flare_flutter/flare_actor.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:wegster_application/screens/phone_Screen.dart';
// import 'package:wegster_application/screens/welcome_page.dart';
// import 'package:wegster_application/themes/dm_color_theme.dart';

// class PinCodeVerificationScreen extends StatefulWidget {
//   //final String phoneNumber;

//   const PinCodeVerificationScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _PinCodeVerificationScreenState createState() =>
//       _PinCodeVerificationScreenState();
// }

// class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
//   // ignore: prefer_typing_uninitialized_variables
//   var onTapRecognizer;
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   TextEditingController textEditingController = TextEditingController();
//   // ..text = "123456";

//   late StreamController<ErrorAnimationType> errorController;

//   bool hasError = false;
//   String currentText = "";
//   final GlobalKey<ScaffoldState> Key = GlobalKey<ScaffoldState>();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     onTapRecognizer = TapGestureRecognizer()
//       ..onTap = () {
//         Navigator.pop(context);
//       };
//     errorController = StreamController<ErrorAnimationType>();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     errorController.close();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var code = "";
//     return Scaffold(
//       backgroundColor: DMColors.backgroundwhiteColor,
//       key: Key,
//       body: GestureDetector(
//         onTap: () {},
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: ListView(
//             children: <Widget>[
//               Image.asset(
//                 'assets/image/otp.png',
//                 height: 250,
//                 width: 530,
//               ),

//               const SizedBox(height: 10),
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   'Phone Number Verification',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
//                 child: RichText(
//                   // ignore: prefer_const_constructors
//                   text: TextSpan(
//                       text: "Enter the code sent to ",
//                       children: const [],
//                       style: const TextStyle(
//                           color: DMColors.blackColor,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Form(
//                 key: formKey,
//                 child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 30),
//                     child: PinCodeTextField(
//                       appContext: context,
//                       pastedTextStyle: TextStyle(
//                         color: Colors.green.shade600,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       length: 6,
//                       obscureText: false,
//                       //obscuringCharacter: '*',
//                       animationType: AnimationType.slide,

//                       validator: (value) {
//                         if (value!.length < 3) {
//                           return "Provide Defined Value";
//                         } else {
//                           return null;
//                         }
//                       },
//                       pinTheme: PinTheme(
//                         shape: PinCodeFieldShape.box,
//                         borderRadius: BorderRadius.circular(8),
//                         fieldHeight: 60,
//                         fieldWidth: 50,
//                         activeFillColor: hasError
//                             ? DMColors.greenColor
//                             : DMColors.backgroundwhiteColor,
//                       ),
//                       cursorColor: DMColors.backgroundwhiteColor,
//                       animationDuration: const Duration(milliseconds: 200),
//                       textStyle: const TextStyle(fontSize: 20),

//                       enableActiveFill: true,
//                       errorAnimationController: errorController,
//                       controller: textEditingController,
//                       keyboardType: TextInputType.number,

//                       boxShadows: const [
//                         BoxShadow(
//                           offset: Offset(3, 2),
//                           color: DMColors.googleColor,
//                           blurRadius: 5,
//                         )
//                       ],
//                       onCompleted: (value) {
//                         if (kDebugMode) {
//                           print("Completed");
//                         }
//                       },
//                       // onTap: () {
//                       //   print("Pressed");
//                       // },
//                       onChanged: (value) {
//                         if (kDebugMode) {
//                           print(value);
//                         }

//                         code = value;
//                       },
//                     )),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 100),
//                 child: Text(
//                   hasError ? "*Please fill up all the cells properly" : "",
//                   style: const TextStyle(
//                       color: DMColors.marronColor,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                     text: "Didn't receive the code? ",
//                     style: const TextStyle(
//                         color: DMColors.blackColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700),
//                     children: [
//                       TextSpan(
//                           text: " RESEND ",
//                           recognizer: onTapRecognizer,
//                           style: const TextStyle(
//                             color: DMColors.logoColor,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 17,
//                           ))
//                     ]),
//               ),
//               // ignore: prefer_const_constructors
//               SizedBox(
//                 height: 30,
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   try {
//                     PhoneAuthCredential credential =
//                         PhoneAuthProvider.credential(
//                             verificationId: MyPhone.verify, smsCode: code);

//                     // Sign the user in (or link) with the credential
//                     await auth.signInWithCredential(credential);
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const WelcomeScreen(),
//                     ));
//                   } catch (e) {
//                     print('Invalid Code');
//                   }

//                   // formKey.currentState?.validate();
//                   // // conditions for validating
//                   // if (currentText.length != 5 || currentText != "Ayush") {
//                   //   errorController.add(ErrorAnimationType
//                   //       .shake); // Triggering error shake animation
//                   //   setState(() {
//                   //     hasError = true;
//                   //   });
//                   // } else {
//                   //   setState(() {
//                   //     hasError = false;
//                   //     // scaffoldKey.currentState.showSnackBar(SnackBar(
//                   //     //   content: Text("Aye!!"),
//                   //     //   duration: Duration(seconds: 2),
//                   //     // ));
//                   //   });
//                   // }
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 90),
//                   child: Container(
//                     width: double.infinity,
//                     height: 50,
//                     decoration: BoxDecoration(
//                         color: DMColors.logoColor,
//                         //color: Colors.green.shade300,
//                         borderRadius: BorderRadius.circular(5),
//                         // ignore: prefer_const_literals_to_create_immutables
//                         boxShadow: [
//                           const BoxShadow(
//                               color: DMColors.googleColor,
//                               offset: Offset(1, -2),
//                               blurRadius: 5),
//                         ]),
//                     child: Center(
//                         child: Text(
//                       "VERIFY".toUpperCase(),
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     )),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   textEditingController.clear();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 140),
//                   child: Container(
//                     width: double.infinity,
//                     height: 50,
//                     decoration: BoxDecoration(
//                         color: DMColors.logoColor,
//                         //color: Colors.green.shade300,
//                         borderRadius: BorderRadius.circular(5),
//                         // ignore: prefer_const_literals_to_create_immutables
//                         boxShadow: [
//                           const BoxShadow(
//                               color: DMColors.googleColor,
//                               offset: Offset(1, -2),
//                               blurRadius: 5),
//                         ]),
//                     child: const Center(
//                         child: Text(
//                       "Clear",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     )),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
