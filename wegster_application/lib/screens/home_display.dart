// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, unused_local_variable, sized_box_for_whitespace, unnecessary_string_interpolations, unnecessary_new, avoid_types_as_parameter_names, avoid_unnecessary_containers, prefer_const_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:wegster_application/api/auth/django_authentication_api.dart';

import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/screens/bookings.dart';

import '../widgets/constants.dart';

class HotelPageDisplay extends StatefulWidget {
  final String Hotel_Name;
  final String Hotel_Email;
  final String Hotel_Location;

  final String Hotel_Image;

  final String Hotel_Price;
  final String Hotel_Description;
  final int Hotel_ID;

  const HotelPageDisplay({
    Key? key,
    required this.Hotel_Name,
    required this.Hotel_Email,
    required this.Hotel_Location,
    required this.Hotel_Image,
    required this.Hotel_Price,
    required this.Hotel_Description,
    required this.Hotel_ID,
  }) : super(key: key);

  @override
  State<HotelPageDisplay> createState() => _HotelPageDisplayState();
}

class _HotelPageDisplayState extends State<HotelPageDisplay> {
  String? Rating;
  String locationMessage = 'Current Location of the User';
  late String lat;
  late String lon;
  String currentLocation = 'Current Address of the User';
  TextEditingController reviewController = TextEditingController();
  // String selectedRoomType = '';
  // DateTime checkInDate = DateTime.now();
  // DateTime checkOutDate = DateTime.now().add(const Duration(days: 1));

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
          "${place.locality}, ${place.subAdministrativeArea},${place.administrativeArea},${place.country},${place.isoCountryCode}";
      setState(() {});
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  final style = TextStyle(
      fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.w900);

  final style2 = TextStyle(
      fontSize: 22, color: Colors.grey[800], fontWeight: FontWeight.w800);

  final style3 = TextStyle(
    fontSize: 12,
    color: Colors.grey[800],
  );

  final style5 = TextStyle(
    fontSize: 16,
    color: Colors.grey[800],
    fontWeight: FontWeight.w800,
  );

  final style7 = TextStyle(
    fontSize: 14,
    color: Colors.grey[600],
    fontWeight: FontWeight.w800,
  );

  final style6 = TextStyle(
    fontSize: 12,
    color: Colors.grey[500],
  );

  final style4 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.grey[600],
  );

  @override
  Widget build(BuildContext context) {
    User user = context.read<CubitUser>().state;
    String Hotel_Name = widget.Hotel_Name;
    //int Restaurant_ID = widget.Hotel_Id;
    int userID = user.id!;
    String Hotel_Location = widget.Hotel_Location;
    String Hotel_Price = widget.Hotel_Price;
    String Hotel_email = widget.Hotel_Email;
    int Hotel_ID = widget.Hotel_ID;
    // String text = widget.text!;
    // String rating = widget.ratings!;

    return Scaffold(
      backgroundColor: DMColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: DMColors.loginColor),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [DMColors.logoColor, DMColors.lightGreenColor],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft)),
        ),
        //backgroundColor: DMColors.logoColor,
        elevation: 7.0,
        title: const LabelText(
            name: 'Wegster',
            color: DMColors.loginColor,
            size: 25,
            fontWeight: FontWeight.w800,
            fontFamily: 'ProximaNova',
            textDecoration: TextDecoration.none),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(15),
          child: Text(
            user.address!,
            style: const TextStyle(
                color: DMColors.backgroundwhiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 4),
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(5, 0), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                      image: NetworkImage(widget.Hotel_Image),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                //padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(5, 0), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: LabelText(
                          name: widget.Hotel_Name,
                          color: DMColors.blackColor,
                          size: 25,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 90,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(5, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  // borderRadius: const BorderRadius.all(
                  //   Radius.circular(15),
                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const LabelText(
                          name: 'Price For Room',
                          color: DMColors.blackColor,
                          size: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: "ProximaNova",
                          textDecoration: TextDecoration.none),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const LabelText(
                              name: 'Rs',
                              color: DMColors.blackColor,
                              size: 19,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          const SizedBox(
                            width: 4,
                          ),
                          LabelText(
                              name: widget.Hotel_Price,
                              color: DMColors.blackColor,
                              size: 19,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const LabelText(
                          name: "+ No Taxes and charges",
                          color: DMColors.blackColor,
                          size: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(5, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  // borderRadius: const BorderRadius.all(
                  //   Radius.circular(15),
                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ignore: prefer_const_constructors
                      LabelText(
                          name: "Most Popular facilities",
                          color: DMColors.blackColor,
                          size: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      const SizedBox(
                        height: 15,
                      ),

                      Row(
                        children: [
                          // Icon(Icons.safety_check_outlined),
                          const LabelText(
                              name: 'Swimming Pool',
                              color: DMColors.blackColor,
                              size: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),

                          Padding(
                            padding: const EdgeInsets.only(left: 140),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.local_parking,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                LabelText(
                                    name: 'Free Parking',
                                    color: DMColors.blackColor,
                                    size: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'ProximaNova',
                                    textDecoration: TextDecoration.none),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          // Icon(Icons.safety_check_outlined),
                          const LabelText(
                              name: 'Non- smoking rooms',
                              color: DMColors.blackColor,
                              size: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),

                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.restaurant,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                LabelText(
                                    name: 'Restaurant',
                                    color: DMColors.blackColor,
                                    size: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'ProximaNova',
                                    textDecoration: TextDecoration.none),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          // Icon(Icons.safety_check_outlined),
                          const LabelText(
                              name: 'Room Service',
                              color: DMColors.blackColor,
                              size: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),

                          Padding(
                            padding: const EdgeInsets.only(left: 140),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.local_parking,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                LabelText(
                                    name: 'Private Parking',
                                    color: DMColors.blackColor,
                                    size: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'ProximaNova',
                                    textDecoration: TextDecoration.none),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 190,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(5, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LabelText(
                          name: "Description",
                          color: DMColors.blackColor,
                          size: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      const SizedBox(
                        height: 10,
                      ),
                      LabelText(
                          name: widget.Hotel_Description,
                          color: DMColors.blackColor,
                          size: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(5, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LabelText(
                          name: "Policies",
                          color: DMColors.blackColor,
                          size: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      const SizedBox(
                        height: 20,
                      ),
                      const LabelText(
                          name: 'Check- in from 12:00 until 12:00',
                          color: DMColors.blackColor,
                          size: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      const SizedBox(
                        height: 7,
                      ),
                      const LabelText(
                          name: 'Check- in from 12:00 until 12:00',
                          color: DMColors.blackColor,
                          size: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 23,
                            width: 35,
                            color: DMColors.darkgreenColor,
                            child: const Center(
                              child: Text(
                                'Free',
                                style: TextStyle(color: DMColors.loginColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            children: const [
                              LabelText(
                                  name:
                                      'Free private parking is possible on site',
                                  color: DMColors.blackColor,
                                  size: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                              SizedBox(
                                height: 5,
                              ),
                              LabelText(
                                  name: '(reservation is needed).',
                                  color: DMColors.blackColor,
                                  size: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const LabelText(
                          name: 'No booking or credit card fees',
                          color: DMColors.blackColor,
                          size: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(5, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          LabelText(
                              name: 'Transport information *',
                              color: DMColors.blackColor,
                              size: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          SizedBox(
                            width: 170,
                          ),
                          Icon(
                            Icons.local_parking_outlined,
                            size: 20,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const LabelText(
                          name: 'Free parking is available',
                          color: DMColors.blackColor,
                          size: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: const [
                          Flexible(
                            flex: 1,
                            child: Divider(
                              color: DMColors.googleColor,
                              thickness: 0.45,
                              height: 0,

                              //endIndent: ,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Divider(
                              color: DMColors.googleColor,
                              thickness: 0.45,
                              height: 0,
                              //endIndent: 11.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const LabelText(
                          name:
                              'All distances are measured in straight lines. Actual travel distances may vary',
                          color: DMColors.blackColor,
                          size: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(5, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          LabelText(
                              name: 'Ratings and Reviews',
                              color: DMColors.blackColor,
                              size: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'ProximaNova',
                              textDecoration: TextDecoration.none),
                          SizedBox(
                            width: 150,
                          ),
                          Icon(
                            Icons.reviews,
                            size: 20,
                          ),
                          SizedBox(width: 15),
                          Icon(
                            Icons.rate_review,
                            size: 20,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: const [
                          Flexible(
                            flex: 1,
                            child: Divider(
                              color: DMColors.googleColor,
                              thickness: 0.45,
                              height: 0,

                              //endIndent: ,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Divider(
                              color: DMColors.googleColor,
                              thickness: 0.45,
                              height: 0,
                              //endIndent: 11.0,
                            ),
                          ),
                        ],
                      ),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 45,
                        glow: true,
                        glowRadius: 8.0,
                        //wrapAlignment: WrapAlignment.center,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 6.0),
                        // ignore: prefer_const_constructors
                        itemBuilder: (context, int) => Icon(
                          Icons.star,
                          color: DMColors.yellowColor,
                        ),
                        onRatingUpdate: (rating) {
                          Rating = rating.toString();
                          print(rating);
                        },
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: reviewController,

                          // onChanged: (value) {
                          //   reviewController.text = value.toString();
                          // },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ("Empty Field");
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Write Your Experience.',
                              prefixIcon: Icon(Icons.rate_review_outlined),
                              prefixIconColor: DMColors.marronColor,

                              //hintTextDirection: TextDirection.ltr,
                              hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: DMColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ProximaNova')),
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: GestureDetector(
                          onTap: () {
                            postReview(Rating!, reviewController.text,
                                Hotel_Name, user.name!, Hotel_ID);
                            setState(() {
                              reviewController.clear();
                            });
                            //GetReviews(Hotel_ID);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: DMColors.orangeColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: const Center(
                              child: LabelText(
                                  name: 'Submit',
                                  color: DMColors.loginColor,
                                  size: 18,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                              backgroundColor: DMColors.backgroundColor,
                              elevation: 8.0,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 800,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          FutureBuilder(
                                            future: GetReviews(Hotel_ID),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              Widget widget = Text("");
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                print(snapshot.error);
                                                return const Center(
                                                  child: Text(
                                                      "Something went wrong"),
                                                );
                                              } else {
                                                if (snapshot.hasData) {
                                                  if (snapshot.hasData &&
                                                      snapshot.data.isEmpty) {
                                                    widget = Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Center(
                                                        //   child: Lottie.asset(
                                                        //       'Assets/LottieAnimations/No_Data_Found_Lottie.json',
                                                        //       height: 220.h,
                                                        //       width: 250.w),
                                                        // ),
                                                      ],
                                                    );
                                                  } else {
                                                    widget = Column(
                                                      children: [
                                                        Center(
                                                          child: Column(
                                                              children: snapshot
                                                                  .data
                                                                  .map<Widget>(
                                                                      (e) {
                                                            int id = e.id;
                                                            double rating =
                                                                e.rating;
                                                            String Review =
                                                                "${e.Review}";
                                                            String Hotelname =
                                                                "${e.Hotelname}";

                                                            String
                                                                Customer_Name =
                                                                "${e.Customer_Name}";

                                                            return Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 16,
                                                                      right: 16,
                                                                      bottom:
                                                                          10,
                                                                      top: 10),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  bottom: BorderSide(
                                                                      color: Colors
                                                                          .black12,
                                                                      width: 1),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      // CircleAvatar(
                                                                      //   radius:
                                                                      //       30,
                                                                      //   backgroundImage:
                                                                      //       AssetImage('Assets/images/Icon.png'),
                                                                      // ),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            "${Customer_Name}",
                                                                            // style:
                                                                            //     GoogleFonts.lato(
                                                                            //   textStyle: style5,
                                                                            // ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          RatingBar
                                                                              .builder(
                                                                            initialRating:
                                                                                rating,
                                                                            minRating:
                                                                                1,
                                                                            direction:
                                                                                Axis.horizontal,
                                                                            allowHalfRating:
                                                                                true,
                                                                            itemCount:
                                                                                5,
                                                                            itemPadding:
                                                                                EdgeInsets.symmetric(horizontal: 0),
                                                                            itemBuilder: (context, _) =>
                                                                                Icon(
                                                                              Icons.star,
                                                                              color: Colors.amber,
                                                                              size: 5,
                                                                            ),
                                                                            tapOnlyMode:
                                                                                true,
                                                                            ignoreGestures:
                                                                                true,
                                                                            onRatingUpdate:
                                                                                (rating) {
                                                                              print(rating);
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            20),
                                                                    child: Text(
                                                                      "${Review}",
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }).toList()),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                } else {
                                                  widget = const Center(
                                                      child: Text("NO DATA"));
                                                }
                                              }

                                              return widget;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => Review(Hotel_ID: Hotel_ID),
                            // ));
                          },
                          child: Text('View Review')),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RoomBooking(
              Hotel_ID: widget.Hotel_ID,
              Hotel_Price: Hotel_Price,
              HotelName: Hotel_Name,
              Hotel_Location: Hotel_Location,
            ),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            width: double.infinity,
            height: 55,
            color: DMColors.logoColor,
            child: const Center(
              child: LabelText(
                  name: 'Select Rooms',
                  color: DMColors.loginColor,
                  size: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ProximaNova',
                  textDecoration: TextDecoration.none),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> postReview(String Rating, String Review, String Hotelname,
      String Customer_Name, int Hotel_ID) async {
    String FK = Hotel_ID.toString();
    var url = Uri.parse("$baseUrl/user/Review/");
    var res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "Rating": Rating,
          "Review": Review,
          "Hotelname": Hotelname,
          "Customer_Name": Customer_Name,
          "Hotel_ID": FK
        }));
    print(res.body);
    print(res.statusCode);

    if (res.statusCode == 200 || res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Review has been posted",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "Sorry! Something went wrong",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      print("Sorry");
    }
  }
}
