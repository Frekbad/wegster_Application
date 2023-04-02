// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_final_fields, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/google_sign/google_auth.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/screens/onboard_screen.dart';

import '../models/user_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _value = "-1";
  late TextEditingController dateconfirmController;

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    dateconfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    dateconfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = context.read<CubitUser>().state;

    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DMColors.backgroundwhiteColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DMColors.logoColor,
        title: Row(
          children: [
            const LabelText(
                name: 'Your Details',
                color: DMColors.loginColor,
                size: 23,
                fontWeight: FontWeight.w800,
                fontFamily: 'ProximaNova',
                textDecoration: TextDecoration.none),
            const SizedBox(
              width: 130,
            ),
            GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Your Profile Has been Updated",
                    fontSize: 18,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: DMColors.lightGreenColor,
                    textColor: Colors.white);
              },
              child: const LabelText(
                  name: 'Save',
                  color: DMColors.loginColor,
                  size: 21,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'ProximaNova',
                  textDecoration: TextDecoration.none),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Lottie.asset('assets/image/lottie/update.json',
                  width: 230, height: 250),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    color: DMColors.loginColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: LabelText(
                            name: 'Personal details',
                            color: DMColors.blackColor,
                            size: 17,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ProximaNova',
                            textDecoration: TextDecoration.none),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          width: double.infinity,
                          child: DropdownButtonFormField(
                            value: _value,
                            items: const [
                              DropdownMenuItem(
                                value: "-1",
                                child: Text('Title'),
                              ),
                              DropdownMenuItem(
                                value: "1",
                                child: Text('Mr.'),
                              ),
                              DropdownMenuItem(
                                value: "2",
                                child: Text('Mrs.'),
                              ),
                            ],
                            onChanged: (v) {},
                          ),
                          // child: TextFormField(
                          //   decoration: const InputDecoration(
                          //     labelText: 'Title',
                          //   ),
                          // ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Address'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 100,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  // padding: const EdgeInsets.symmetric(vertical: 20),

                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2)),
                    color: DMColors.loginColor,
                    boxShadow: [
                      BoxShadow(
                        color: DMColors.blackColor.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: LabelText(
                            name: 'Social Linking',
                            color: DMColors.blackColor,
                            size: 17,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ProximaNova',
                            textDecoration: TextDecoration.none),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SvgPicture.asset('assets/image/google.svg'),
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          const LabelText(
                              name: 'Google',
                              color: DMColors.blackColor,
                              size: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            width: 185,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await GoogleSignInApi.logout();
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
                                      title: const Text(
                                          'Are You Sure You Want to Log Out?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('NO')),
                                        TextButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          DMColors.redColor,
                                                      content: Text(
                                                        "Logged Out Successfully",
                                                        textAlign:
                                                            TextAlign.center,
                                                      )));
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const OnboardingScreen(),
                                                      ),
                                                      (route) => false);
                                            },
                                            child: const Text('Yes'))
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const LabelText(
                                name: 'Disconnect',
                                color: DMColors.redColor,
                                size: 17,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'ProximaNova',
                                textDecoration: TextDecoration.none),
                          )
                        ],
                      ),
                      // const Text('Connected as:')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Container(
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: DMColors.blackColor.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                    color: DMColors.loginColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () async {
                        await logoutUser(user.token!);
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
                                title: const Text(
                                    'Are You Sure You Want to Log Out?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('NO')),
                                  TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor:
                                                    DMColors.redColor,
                                                content: Text(
                                                  "Logged Out Successfully",
                                                  textAlign: TextAlign.center,
                                                )));
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const OnboardingScreen(),
                                                ),
                                                (route) => false);
                                      },
                                      child: const Text('Yes'))
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const LabelText(
                          name: 'Sign out',
                          color: DMColors.redColor,
                          size: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none)),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
