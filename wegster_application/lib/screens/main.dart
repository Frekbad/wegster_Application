// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:flutter/services.dart';
import 'package:wegster_application/notification_Screen/notification_screen.dart';

import 'package:wegster_application/screens/button_navigation.dart';
import 'package:wegster_application/screens/home_page.dart';
import 'package:wegster_application/screens/onboard_screen.dart';
import 'package:wegster_application/screens/phone_Screen.dart';
//import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:wegster_application/screens/splash_screen.dart';
import 'package:wegster_application/vendor_Screen/VbuttonNavigation.dart';
import 'package:wegster_application/vendor_Screen/hotelDashboard.dart';

void main() async {
  //khaltiFlutter.init("");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return BlocProvider(
      create: (BuildContext context) {
        return CubitUser(User());
      },
      child: KhaltiScope(
        builder: (context, navKey) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: OnboardingScreen(),
            routes: {
              "/home": (context) => new ButtonNavigation(),
              "/vendorhome": (context) => new VButtonNavigation()
            },

            navigatorKey: navKey,
            // ignore: prefer_const_literals_to_create_immutables
            localizationsDelegates: [KhaltiLocalizations.delegate],
          );
        },
        publicKey: 'test_public_key_72883f38393a41228b405fefcd5accb1',
        enabledDebugging: true,
      ),
    );
  }
}
