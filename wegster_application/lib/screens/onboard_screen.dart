// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wegster_application/models/onboard_model.dart';
import 'package:wegster_application/screens/welcome_page.dart';
import 'package:wegster_application/themes/dm_color_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  String onboardingKey = 'isOnboardingShown';
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//shared preference
  _storeOnBoardingInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(
      onboardingKey,
      true,
    );
  }

//goes to next page when called
  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

//goes to previous page when called
  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: currentIndex % 2 == 0
            ? Theme.of(context).backgroundColor
            : DMColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: currentIndex % 2 == 0
              ? Theme.of(context).backgroundColor
              : DMColors.backgroundColor,
          elevation: 0,
          leading: currentIndex == 0
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 37.0,
                    color: currentIndex > 1
                        ? DMColors.loginColor
                        : DMColors.logoColor,
                  ),
                  onPressed: () => previousPage(),
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: screens.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SvgPicture.asset(
                        screens[index].img,
                        //color: screens[index].color,
                      ),
                    ),
                  ),
                  Text(
                    screens[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: currentIndex % 2 == 0
                            ? DMColors.blackColor
                            : DMColors.blueColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                    child: Text(
                      screens[index].desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: currentIndex % 2 == 0
                              ? DMColors.blackColor
                              : DMColors.blueColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    child: ListView.builder(
                        itemCount: screens.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                width: currentIndex == index ? 35 : 15,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: currentIndex % 2 == 0
                                        ? DMColors.blackColor
                                        : DMColors.blueColor,
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            ],
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await _storeOnBoardingInfo();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ));
                            // ignore: use_build_context_synchronously
                            //GoRouter.of(context).go('/welcomePage');
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 20,
                              color: currentIndex % 2 == 0
                                  ? DMColors.blackColor
                                  : DMColors.blueColor,
                            ),
                          )),
                      GestureDetector(
                          onTap: () async {
                            if (index == screens.length - 1) {
                              await _storeOnBoardingInfo();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const WelcomeScreen(),
                              ));

                              //GoRouter.of(context).go('/welcomePage');
                              return;
                            }
                            nextPage();
                          },
                          child: currentIndex == screens.length - 1
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: currentIndex % 2 == 0
                                          ? DMColors.blueColor
                                          : DMColors.logoColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: currentIndex == screens.length - 1
                                      ? Text(
                                          'Get Started',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: currentIndex % 2 == 0
                                                  ? DMColors.loginColor
                                                  : DMColors.blueColor),
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: currentIndex % 2 == 0
                                                ? DMColors.googleColor
                                                : DMColors.loginColor,
                                          ),
                                          onPressed: () => nextPage(),
                                        ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: currentIndex % 2 == 0
                                          ? DMColors.blueColor
                                          : DMColors.logoColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: currentIndex == screens.length - 1
                                      ? Text(
                                          'Get Started',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: currentIndex % 2 == 0
                                                  ? DMColors.loginColor
                                                  : DMColors.blueColor),
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: currentIndex % 2 == 0
                                                ? DMColors.googleColor
                                                : DMColors.loginColor,
                                          ),
                                          onPressed: () => nextPage(),
                                        ),
                                )),
                    ],
                  )
                ],
              );
            },
          ),
        ));
  }
}
