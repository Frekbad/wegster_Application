// ignore_for_file: use_build_context_synchronously, unused_label, unused_local_variable, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, sort_child_properties_last

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';

import 'package:wegster_application/bus_Screen/bus_List.dart';

import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/screens/home_display.dart';
import 'package:wegster_application/screens/log_in_screen.dart';
import 'package:wegster_application/screens/search.dart';
import 'package:wegster_application/widgets/todo_container.dart';
import 'package:http/http.dart' as http;

import '../exports/exports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String locationMessage = 'Current Location of the User';
  late String lat;
  late String lon;
  String currentLocation = 'Current Address of the User';

  Future<Position> getCurrentLocationUser() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied, we cannot request');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatlon(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      // ignore: avoid_print
      print(placemarks);

      Placemark place = placemarks[0];

      currentLocation =
          "${place.locality}, ${place.subAdministrativeArea},${place.administrativeArea},${place.country}";
      setState(() {});
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    resizeToAvoidBottomInset:
    false;
    backgroundColor:
    DMColors.backgroundColor;
    User user = context.read<CubitUser>().state;
    return RefreshIndicator(
      onRefresh: () async {
        VendorData();
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DMColors.loginColor),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: SearchUser());
                },
              ),
            )
          ],
          //backgroundColor: DMColors.logoColor,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: const [
              DMColors.logoColor,
              DMColors.lightGreenColor
            ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
          ),
          elevation: 7.0,
          title: LabelText(
              name: 'Wegster',
              color: DMColors.loginColor,
              size: 25,
              fontWeight: FontWeight.w800,
              fontFamily: 'ProximaNova',
              textDecoration: TextDecoration.none),
          centerTitle: true,

          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Text(
              user.address!,
              style: TextStyle(
                  color: DMColors.backgroundwhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              //physics: ClampingScrollPhysics(),
              child: Column(children: [
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: DMColors.blueColor.withOpacity(0.2),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: DMColors.loginColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const HBookingSection(),
                          // ),
                          // );
                        },
                        child: Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: DMColors.logoColor.withOpacity(0.3)),
                          child: SvgPicture.asset(
                            'assets/image/hotelicon.svg',
                            height: 5,
                            //width: 20,
                            color: DMColors.orangeColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BusListScreen(),
                          ));
                        },
                        child: Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: DMColors.redColor.withOpacity(0.3)),
                          child: SvgPicture.asset(
                            'assets/image/busicon.svg',
                            height: 5,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(height: 15),
            Center(
                child: FutureBuilder(
              future: VendorData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Widget widget = Text("");
                if (snapshot.hasData) {
                  widget = Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: LabelText(
                                name: 'Nearby Stays for tonight',
                                color: DMColors.blackColor,
                                size: 22,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'ProximaNova',
                                textDecoration: TextDecoration.none),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 9),
                            child: LabelText(
                                name: 'See more',
                                color: DMColors.logoColor,
                                size: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'ProximaNova',
                                textDecoration: TextDecoration.none),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: snapshot.data.map<Widget>((e) {
                          int Hotel_ID = e.Hotel_ID;
                          String Hotel_Token = "${e.Hotel_Token}";
                          String Hotel_Email = "${e.Hotel_Email}";
                          String Hotel_Name = "${e.Hotel_Name}";
                          String Hotel_Location = "${e.Hotel_Location}";
                          String Hotel_Image = "${e.Hotel_Image}";
                          String Hotel_Price = "${e.Hotel_Price}";
                          String Hotel_Description = "${e.Hotel_Description}";
                          //String Room_Id = "${e.Room_Id}";

                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => HotelPageDisplay(
                                              Hotel_Name: Hotel_Name,
                                              Hotel_Email: Hotel_Email,
                                              Hotel_Location: Hotel_Location,
                                              Hotel_Image: Hotel_Image,
                                              Hotel_Price: Hotel_Price,
                                              Hotel_Description:
                                                  Hotel_Description,
                                              Hotel_ID: Hotel_ID,
                                              //Room_Id: Room_Id,
                                            )));
                              },
                              child: TodoContainer(
                                  Hotel_Email: Hotel_Email,
                                  Hotel_ID: Hotel_ID,
                                  Hotel_Image: Hotel_Image,
                                  Hotel_Location: Hotel_Location,
                                  Hotel_Name: Hotel_Name,
                                  Hotel_Token: Hotel_Token,
                                  Hotel_Price: Hotel_Price,
                                  Hotel_Description: Hotel_Description));
                        }).toList()),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  widget = Center(
                    child: Text("Something went wrong"),
                  );
                } else {
                  widget = const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return widget;
              },
            )),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 10),
                LabelText(
                    name: 'Travel more, spend less',
                    color: DMColors.blackColor,
                    size: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                    width: 230,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          LabelText(
                              name: 'Genius',
                              color: DMColors.loginColor,
                              size: 17,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          SizedBox(height: 10),
                          Row(
                            children: const [
                              LabelText(
                                  name: 'You are at ',
                                  color: DMColors.loginColor,
                                  size: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                              LabelText(
                                  name: 'Genuis Level 1 ',
                                  color: DMColors.loginColor,
                                  size: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                            ],
                          ),
                          LabelText(
                              name: 'in our loyalty programme ',
                              color: DMColors.loginColor,
                              size: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 230,
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: DMColors.blueColor),
                      //color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          LabelText(
                              name: '15 % discounts',
                              color: DMColors.blackColor,
                              size: 17,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          SizedBox(height: 10),
                          Row(
                            children: const [
                              LabelText(
                                  name: 'Enjoy discounts at  ',
                                  color: DMColors.blackColor,
                                  size: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                              LabelText(
                                  name: 'Here ',
                                  color: DMColors.blackColor,
                                  size: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                            ],
                          ),
                          LabelText(
                              name: 'properties worldwide',
                              color: DMColors.blackColor,
                              size: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 230,
                    height: 140,
                    decoration: BoxDecoration(
                      color: DMColors.googleColor,
                      border:
                          Border.all(color: DMColors.googleColor2, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          LabelText(
                              name: '10 % discounts',
                              color: DMColors.blackColor,
                              size: 17,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          SizedBox(height: 10),
                          Row(
                            children: const [
                              LabelText(
                                  name: 'Enjoy discounts at  ',
                                  color: DMColors.blackColor,
                                  size: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                              LabelText(
                                  name: 'Here ',
                                  color: DMColors.blackColor,
                                  size: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                            ],
                          ),
                          LabelText(
                              name: 'properties worldwide',
                              color: DMColors.blackColor,
                              size: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 230,
                    height: 140,
                    decoration: BoxDecoration(
                        color: DMColors.backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: DMColors.googleColor, width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          LabelText(
                              name: 'Free breakfasts',
                              color: DMColors.blackColor,
                              size: 17,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          SizedBox(height: 10),
                          Row(
                            children: const [
                              LabelText(
                                  name: 'Complete stays to ',
                                  color: DMColors.blackColor,
                                  size: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                              LabelText(
                                  name: 'Get Free ',
                                  color: DMColors.blackColor,
                                  size: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                            ],
                          ),
                          LabelText(
                              name: 'BreakFast.',
                              color: DMColors.blackColor,
                              size: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 230,
                    height: 140,
                    decoration: BoxDecoration(
                      color: DMColors.backgroundColor,
                      border:
                          Border.all(color: DMColors.googleColor, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          LabelText(
                              name: 'Free room upgrades',
                              color: DMColors.blackColor,
                              size: 17,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          SizedBox(height: 10),
                          Row(
                            children: const [
                              LabelText(
                                  name: 'Complete 5 stays to ',
                                  color: DMColors.blackColor,
                                  size: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                              LabelText(
                                  name: 'Unlock',
                                  color: DMColors.blackColor,
                                  size: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                            ],
                          ),
                          LabelText(
                              name: 'Free room upgrades.',
                              color: DMColors.blackColor,
                              size: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 35,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: LabelText(
                      name: 'Why book with Wegster.com?',
                      color: DMColors.blackColor,
                      size: 19,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                ),
              ],
            ),

            SizedBox(
              height: 25,
            ),

            Row(
              children: [
                Image.asset(
                  'assets/image/support.jpg',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 50,
                ),
                LabelText(
                    name: '24/7 Customer Support',
                    color: DMColors.blackColor,
                    size: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none)
              ],
            ),
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 30),
                child: Row(
                  children: const [
                    Flexible(
                      flex: 1,
                      child: Divider(
                        color: DMColors.googleColor,
                        thickness: 0.45,
                        height: 0,
                        indent: 11.0,
                        //endIndent: ,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Divider(
                        color: DMColors.googleColor,
                        thickness: 0.45,
                        height: 0,
                        endIndent: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //SizedBox(height: 3),
            Row(
              children: [
                Image.asset(
                  'assets/image/secure.png',
                  height: 30,
                  width: 50,
                ),
                SizedBox(
                  width: 50,
                ),
                LabelText(
                    name: 'Secure Booking Process',
                    color: DMColors.blackColor,
                    size: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none)
              ],
            ),
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 30),
                child: Row(
                  children: const [
                    Flexible(
                      flex: 1,
                      child: Divider(
                        color: DMColors.textColor,
                        thickness: 0.45,
                        height: 0,
                        indent: 11.0,
                        //endIndent: ,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Divider(
                        color: DMColors.textColor,
                        thickness: 0.45,
                        height: 0,
                        endIndent: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Row(
              children: [
                Image.asset(
                  'assets/image/thumps.jpg',
                  height: 30,
                  width: 40,
                ),
                SizedBox(
                  width: 50,
                ),
                LabelText(
                    name: 'Trusted By Members',
                    color: DMColors.blackColor,
                    size: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none)
              ],
            ),
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 30),
                child: Row(
                  children: const [
                    Flexible(
                      flex: 1,
                      child: Divider(
                        color: DMColors.textColor,
                        thickness: 0.45,
                        height: 0,
                        indent: 11.0,
                        //endIndent: ,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Divider(
                        color: DMColors.textColor,
                        thickness: 0.45,
                        height: 0,
                        endIndent: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              children: [
                Image.asset(
                  'assets/image/people.jpg',
                  height: 30,
                  width: 50,
                ),
                SizedBox(
                  width: 50,
                ),
                LabelText(
                    name: '11 Million Happy Members',
                    color: DMColors.blackColor,
                    size: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none)
              ],
            ),
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 30),
                child: Row(
                  children: const [
                    Flexible(
                      flex: 1,
                      child: Divider(
                        color: DMColors.textColor,
                        thickness: 0.45,
                        height: 0,
                        indent: 11.0,
                        //endIndent: ,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Divider(
                        color: DMColors.textColor,
                        thickness: 0.45,
                        height: 0,
                        endIndent: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            // TextButton(
            //     onPressed: () {
            //       initiateKhaltiPayment();
            //     },
            //     child: Text('Khalti'))

            // Center(
            //     child: FutureBuilder(
            //   future: VendorData(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     Widget widget = Text("");
            //     if (snapshot.hasData) {
            //       widget = Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: const [
            //               // SizedBox(
            //               //   width: 20,
            //               // ),
            //               Padding(
            //                 padding: EdgeInsets.only(left: 20),
            //                 child: LabelText(
            //                     name: 'Nearby Stays for tonight',
            //                     color: DMColors.blackColor,
            //                     size: 22,
            //                     fontWeight: FontWeight.w900,
            //                     fontFamily: 'ProximaNova',
            //                     textDecoration: TextDecoration.none),
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.only(right: 9),
            //                 child: LabelText(
            //                     name: 'See more',
            //                     color: DMColors.logoColor,
            //                     size: 18,
            //                     fontWeight: FontWeight.w600,
            //                     fontFamily: 'ProximaNova',
            //                     textDecoration: TextDecoration.none),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 15,
            //           ),
            //           SingleChildScrollView(
            //             scrollDirection: Axis.horizontal,
            //             child: Row(
            //                 children: snapshot.data.map<Widget>((e) {
            //               String Hotel_Id = "${e.Hotel_Id}";
            //               String Hotel_Token = "${e.Hotel_Token}";
            //               String Hotel_Email = "${e.Hotel_Email}";
            //               String Hotel_Name = "${e.Hotel_Name}";
            //               String Hotel_Location = "${e.Hotel_Location}";
            //               String Hotel_Image = "${e.Hotel_Image}";

            //               return GestureDetector(
            //                   onTap: () {},
            //                   child: TodoContainer(
            //                     Hotel_Email: Hotel_Email,
            //                     Hotel_Id: Hotel_Id,
            //                     Hotel_Image: Hotel_Image,
            //                     Hotel_Location: Hotel_Location,
            //                     Hotel_Name: Hotel_Name,
            //                     Hotel_Token: Hotel_Token,
            //                   ));
            //             }).toList()),
            //           ),
            //           SizedBox(
            //             height: 20,
            //           )
            //         ],
            //       );
            //     } else if (snapshot.hasError) {
            //       widget = Center(
            //         child: Text("Something went wrong"),
            //       );
            //     } else {
            //       widget = const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     return widget;
            //   },
            // ))

            // SizedBox(
            //   height: 10,
            // ),

            //Text(user.address!)
          ])),
        ),
      ),
    );
  }
}
