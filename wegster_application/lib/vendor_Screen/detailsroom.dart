// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/screens/welcome_page.dart';
import 'package:wegster_application/vendor_Screen/HotelBookDetails.dart';
import 'package:wegster_application/vendor_Screen/roomadd.dart';
import 'package:wegster_application/vendor_Screen/vendor_RegistrationForm.dart';
import 'package:wegster_application/widgets/constants.dart';

import '../exports/exports.dart';

class VendorMenuItems extends StatefulWidget {
  const VendorMenuItems({
    Key? key,
  }) : super(key: key);

  @override
  State<VendorMenuItems> createState() => _VendorMenuItemsState();
}

class _VendorMenuItemsState extends State<VendorMenuItems> {
  @override
  Widget build(BuildContext context) {
    final Appbarstyle = TextStyle(
        fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold);

    User user = context.read<CubitUser>().state;

    final style = TextStyle(
        fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold);

    final style2 = TextStyle(
        fontSize: 19, color: Colors.grey[800], fontWeight: FontWeight.w600);

    final style3 = TextStyle(
      fontSize: 16,
      color: Colors.grey[700],
    );

    return Scaffold(
      backgroundColor: DMColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70), // Set this height
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: DMColors.logoColor,
              boxShadow: [
                BoxShadow(
                  color: DMColors.marronColor.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(5, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "Hotel Details",
                    style: TextStyle(
                        fontSize: 22,
                        color: DMColors.loginColor,
                        fontWeight: FontWeight.w800),
                    // style: GoogleFonts.lato(
                    //   textStyle: Appbarstyle,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                      color: DMColors.loginColor,
                      boxShadow: [
                        BoxShadow(
                          color: DMColors.googleColor.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(5, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.elliptical(4, 6),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.elliptical(4, 6))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/image/profile.jpg'),
                            backgroundColor: DMColors.loginColor,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${user.name}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: DMColors.logoColor,
                          fontFamily: 'ProximaNova',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_sharp,
                            color: DMColors.marronColor.withOpacity(1.0),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${user.email}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: DMColors.blackColor,
                              fontFamily: 'ProximaNova',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HotelBookDetails(),
                    ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 65,
                    decoration: BoxDecoration(
                        color: DMColors.loginColor,
                        boxShadow: [
                          BoxShadow(
                            color: DMColors.googleColor.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: const Offset(
                                5, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(4, 6),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.elliptical(4, 6))),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.person,
                          color: DMColors.logoColor,
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Hotel Room Book Details",
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: DMColors.blackColor,
                            fontFamily: 'ProximaNova',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VendorAddDeals(HotelID: user.id!),
                    ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 65,
                    decoration: BoxDecoration(
                        color: DMColors.loginColor,
                        boxShadow: [
                          BoxShadow(
                            color: DMColors.googleColor.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: const Offset(
                                5, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(4, 6),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.elliptical(4, 6))),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.edit_location_alt,
                          color: DMColors.redColor,
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Add Room",
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: DMColors.blackColor,
                            fontFamily: 'ProximaNova',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VendorRegistration(),
                    ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 65,
                    decoration: BoxDecoration(
                        color: DMColors.loginColor,
                        boxShadow: [
                          BoxShadow(
                            color: DMColors.googleColor.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: const Offset(
                                5, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(4, 6),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.elliptical(4, 6))),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.post_add,
                          color: DMColors.orangeColor,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Hotel Post ",
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: DMColors.blackColor,
                            fontFamily: 'ProximaNova',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'Log out',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'ProximaNova',
                                    color: DMColors.blackColor,
                                    fontWeight: FontWeight.w800),
                              ),
                              content: const Text(
                                'Are you sure you want to Log out?',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'ProximaNova',
                                    color: DMColors.blackColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await logoutUser(user.token!);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            backgroundColor: DMColors.redColor,
                                            content: Text(
                                              "Logged Out Successfully",
                                              textAlign: TextAlign.center,
                                            )));

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WelcomeScreen()),
                                        (route) => false);
                                  },
                                  child: const Text(
                                    'YES',
                                    style: TextStyle(color: DMColors.logoColor),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor:
                                                  DMColors.lightGreenColor,
                                              content: Text(
                                                "Log Out Cancel",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: DMColors.loginColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                textAlign: TextAlign.center,
                                              )));

                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'NO',
                                      style:
                                          TextStyle(color: DMColors.logoColor),
                                    ))
                              ],
                            ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 65,
                    decoration: BoxDecoration(
                        color: DMColors.loginColor,
                        boxShadow: [
                          BoxShadow(
                            color: DMColors.googleColor.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: const Offset(
                                5, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(4, 6),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.elliptical(4, 6))),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.logout_rounded,
                          color: DMColors.redColor,
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: DMColors.redColor,
                            fontFamily: 'ProximaNova',
                          ),
                        )
                      ],
                    ),
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
