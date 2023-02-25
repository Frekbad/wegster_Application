import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:flutter/services.dart';
import 'package:wegster_application/screens/button_navigation.dart';
import 'package:wegster_application/screens/home_page.dart';
import 'package:wegster_application/screens/onboard_screen.dart';
import 'package:wegster_application/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: OnboardingScreen()),
    );
  }
}
