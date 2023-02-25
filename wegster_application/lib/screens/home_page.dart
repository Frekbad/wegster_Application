// ignore_for_file: use_build_context_synchronously, unused_label, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wegster_application/hotels_Screens/hotels_Booking_Section.dart';

import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';

import '../exports/exports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController pageController;
  int pageNumber = 0;

  String locationMessage = 'Current Location of the User';
  late String lat;
  late String lon;
  String currentLocation = 'Current Address of the User';
  Timer? carasouelTimer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNumber == 5) {
        pageNumber = 0;
      }
      pageController.animateToPage(pageNumber,
          duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      pageNumber++;
    });
  }

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

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTimer = getTimer();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Widget> listofcontainer = [
    GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 36, left: 4),
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/image/profile.jpg'), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    ),
    GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 36, left: 4),
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/image/profile.jpg'), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromARGB(255, 15, 97, 191),
        ),
      ),
    ),
    GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 36, left: 4),
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/image/profile.jpg'), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromARGB(255, 62, 191, 15),
        ),
      ),
    ),
    GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 36, left: 4),
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/image/profile.jpg'), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromARGB(255, 185, 92, 117),
        ),
      ),
    ),
    GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 36, left: 4),
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/image/profile.jpg'), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromARGB(255, 255, 194, 81),
        ),
      ),
    ),
    GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 36, left: 4),
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/image/profile.jpg'), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromARGB(255, 0, 20, 119),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    resizeToAvoidBottomInset:
    false;
    backgroundColor:
    DMColors.backgroundColor;
    User user = context.read<CubitUser>().state;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 110,
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 125, right: 5, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Wegster.Com',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () async {
                      Position position = await getCurrentLocationUser();
                      locationMessage =
                          'Latitude of Place:${position.latitude}, Longitude of Place:${position.longitude}';
                      getAddressFromLatlon(position);

                      setState(() {});
                    },
                    child: Text(
                      currentLocation,

                      textAlign: TextAlign.center,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 20,
                          color: DMColors.loginColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  // ),
                ],
              ),
            ),
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
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HBookingSection(),
                          ));
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
                        onTap: () {},
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

            Container(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  pageNumber = index;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: listofcontainer[index],
                  );
                },
                itemCount: 6,
              ),
            ),
            //Text(user.address!)
          ],
        ),
      ),
    );
  }
}
