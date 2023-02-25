// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';

import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/google_sign/google_auth.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/screens/button_navigation.dart';
import 'package:wegster_application/screens/edit_profile.dart';

import 'package:wegster_application/screens/log_in_screen.dart';

class MyAccount extends StatefulWidget {
  final GoogleSignInAccount? User;

  const MyAccount({
    Key? key,
    this.User,
  }) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  // const LoggedInPage({super.key, required GoogleSignInAccount user});
  @override
  Widget build(BuildContext context) {
    User user = context.read<CubitUser>().state;
    return Scaffold(
      backgroundColor: DMColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: DMColors.backgroundColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ButtonNavigation(),
              ));
            },
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: DMColors.blackColor,
            )),
        title: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Text('Account', style: Theme.of(context).textTheme.headline5),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                LineAwesomeIcons.user,
                color: DMColors.blackColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  const SizedBox(
                    width: 90,
                    height: 90,
                    child: Image(image: AssetImage("assets/image/profile.jpg")),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: DMColors.logoColor),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: DMColors.blackColor,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Name:${user.name}',
                  style: const TextStyle(color: DMColors.blackColor)),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Email:${user.email}',
                style: const TextStyle(color: DMColors.blackColor),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfile(),
                  ));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: DMColors.logoColor),
                  //width: double.infinity,
                  child: const LabelText(
                      name: 'Edit Profile',
                      color: DMColors.blackColor,
                      size: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'ProximaNova',
                      textDecoration: TextDecoration.none),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              AccountMenuWidget(
                title: "Settings",
                icon: LineAwesomeIcons.cog,
                onpress: () {},
              ),
              AccountMenuWidget(
                title: "Reviews",
                icon: LineAwesomeIcons.thumbs_up,
                onpress: () {},
              ),
              AccountMenuWidget(
                title: 'Favorites',
                icon: LineAwesomeIcons.heart,
                onpress: () {},
              ),
              const Divider(
                color: DMColors.googleColor2,
              ),
              const SizedBox(
                height: 10,
              ),
              AccountMenuWidget(
                title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                textcolor: DMColors.redColor,
                endIcon: false,
                onpress: () async {
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
                          title:
                              const Text('Are You Sure You Want to Log Out?'),
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
                                          backgroundColor: DMColors.redColor,
                                          content: Text(
                                            "Logged Out Successfully",
                                            textAlign: TextAlign.center,
                                          )));
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
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
              ),
              AccountMenuWidget(
                title: 'Social Log Out',
                icon: LineAwesomeIcons.alternate_sign_out,
                textcolor: DMColors.redColor,
                endIcon: false,
                onpress: () async {
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
                          title:
                              const Text('Are You Sure You Want to Log Out?'),
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
                                          backgroundColor: DMColors.redColor,
                                          content: Text(
                                            "Logged Out Successfully",
                                            textAlign: TextAlign.center,
                                          )));
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
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
              )
            ],
          ),
        ),
      ),

      // appBar: AppBar(
      //   title: const Text('Logged In'),
      //   centerTitle: true,
      //   actions: [
      //     TextButton(
      //       child: const Text(
      //         'Logout',
      //         style: TextStyle(color: Colors.white),
      //       ),
      //       onPressed: () async {
      //         await GoogleSignInApi.logout();
      //         // ignore: use_build_context_synchronously
      //         Navigator.of(context).pushReplacement(
      //             MaterialPageRoute(builder: (context) => const LoginPage()));
      //       },
      //     )
      //   ],
      // ),
      // body: Container(
      //   alignment: Alignment.center,
      //   color: Colors.blueGrey.shade900,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text(
      //         'Profile',
      //         style: TextStyle(fontSize: 24),
      //       ),
      //       const SizedBox(height: 32),
      //       const CircleAvatar(
      //         radius: 40,
      //       ),
      //       const SizedBox(
      //         height: 8,
      //       ),
      //       ,Text(
      //         'Name:${user.name}',
      //         style: const TextStyle(color: Colors.white),
      //       ),
      //       const SizedBox(
      //         height: 8,
      //       ),
      //       Text(
      //         'Email:${user.email}',
      //         style: const TextStyle(color: Colors.white)
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

class AccountMenuWidget extends StatelessWidget {
  const AccountMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onpress,
    this.endIcon = true,
    this.textcolor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onpress,
        leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: DMColors.blackColor.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              color: DMColors.blackColor,
            )),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1?.apply(color: textcolor),
        ),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: DMColors.blackColor.withOpacity(0.1),
                ),
                child: const Icon(
                  LineAwesomeIcons.angle_right,
                  size: 15,
                  color: DMColors.blackColor,
                ),
              )
            : null);
  }
}
