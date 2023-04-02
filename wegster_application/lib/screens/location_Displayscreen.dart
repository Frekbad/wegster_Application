// ignore_for_file: non_constant_identifier_names, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/screens/splash_screen.dart';
import 'package:wegster_application/widgets/constants.dart';
import 'package:http/http.dart' as http;

class LocationDisplayScreen extends StatefulWidget {
  const LocationDisplayScreen({super.key});

  @override
  State<LocationDisplayScreen> createState() => _LocationDisplayScreenState();
}

class _LocationDisplayScreenState extends State<LocationDisplayScreen> {
  String location = "";
  String Address = "";
  @override
  void initState() {
    super.initState();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(Fluttertoast.showToast(
            msg: "Cannot Set User Location",
            fontSize: 18,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: DMColors.redColor,
            textColor: Colors.white));
      }
      if (permission == LocationPermission.always) {
        return Future.error(Fluttertoast.showToast(
            msg: "Succesfully Set User Location",
            fontSize: 18,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: DMColors.greenColor,
            textColor: Colors.white));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddress(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
    Placemark place = placemark[0];
    Address =
        '${place.street}, ${place.locality}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.country}';
    var box = await Hive.openBox(authBox);
    var keybox = box.get("token");
    await addLocation(keybox, Address);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  Future<dynamic> addLocation(String key, String address) async {
    Map body = {
      "address": address,
    };
    var url = Uri.parse("$baseUrl/user/auth/user/");
    var res = await http.put(url,
        headers: {'Authorization': 'Token ${key}'}, body: body);
    getUser(key);

    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200 || res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Location Has been Set",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: DMColors.greenColor,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "Cannot Set User Location",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: DMColors.redColor,
          textColor: Colors.white);
      print("Sorry");
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontSize: 24, color: Colors.grey[800], fontWeight: FontWeight.w600);

    final style2 = TextStyle(fontSize: 15, color: Colors.grey[500]);

    final font = TextStyle(color: Colors.grey[800], fontSize: 16);

    final locationButton = Material(
        elevation: 7.0,
        borderRadius: BorderRadius.circular(5.0),
        color: DMColors.logoColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.gps_fixed_sharp,
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Use my current Location',
                style: TextStyle(
                    color: DMColors.backgroundwhiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ProximaNova'),
              ),
            ],
          ),
          onPressed: () async {
            Position position = await determinePosition();
            print(position.latitude);
            location =
                'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
            GetAddress(position);
          },
        ));

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/image/lopi.svg",
                  //height: 60,
                  width: 70,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: LabelText(
                      name: 'Wegster',
                      color: DMColors.logoColor,
                      size: 35.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.center,
              child: LabelText(
                  name: 'User Location',
                  color: DMColors.blackColor,
                  size: 28,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'ProximaNova',
                  textDecoration: TextDecoration.none),
            ),
            Center(
              child: Lottie.asset('assets/image/lottie/location.json',
                  height: 340, width: 400),
            ),
            const Text(
              "Set your location.",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'ProximaNova',
                  fontWeight: FontWeight.w700,
                  color: DMColors.logoColor),
              //style: GoogleFonts.lato(textStyle: style2),
            ),
            const SizedBox(
              height: 50,
            ),
            locationButton,
          ],
        ),
      )),
    );
  }
}
