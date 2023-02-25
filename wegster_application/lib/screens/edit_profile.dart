// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

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
      backgroundColor: DMColors.backgroundColor,
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
              onTap: () {},
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
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: DMColors.loginColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: LabelText(
                            name: 'User Details',
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
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Display name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-z]+$').hasMatch(value)) {
                                return "Enter Correct Name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: dateconfirmController,
                            onTap: () async {
                              DateTime? showDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2700));

                              if (showDate != null) {
                                setState(() {
                                  dateconfirmController.text =
                                      DateFormat('yyyy-MM-dd').format(showDate);
                                });
                              }
                            },
                            decoration: const InputDecoration(
                                labelText: 'Date of birth'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: LabelText(
                            name:
                                'We will show the age range next to your guest reviews.',
                            color: DMColors.blackColor,
                            size: 13,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'ProximaNova',
                            textDecoration: TextDecoration.none),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Location'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
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
                                const InputDecoration(labelText: 'Location'),
                          ),
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
                                const InputDecoration(labelText: 'Gender'),
                          ),
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
                                const InputDecoration(labelText: 'Address'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  // padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: DMColors.loginColor,
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
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
                      borderRadius: BorderRadius.circular(15)),
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
