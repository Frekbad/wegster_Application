import 'package:flutter/material.dart';
import 'package:wegster_application/drawer/drawer.dart';

import '../exports/exports.dart';

class Navigatordrawer extends StatelessWidget {
  const Navigatordrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: DMColors.backgroundwhiteColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              children: [
                HeaderDrawer(),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  thickness: 0.1,
                  height: 0,
                  color: DMColors.textColor,
                ),
                SizedBox(
                  height: 10,
                ),
                DrawerItem(
                  name: 'Home',
                  color: DMColors.textColor,
                  image: "assets/image/home.svg",
                ),
                DrawerItem(
                    name: 'Explore',
                    color: DMColors.textColor,
                    image: "assets/image/compass.svg"),
                SizedBox(
                  height: 110,
                ),
                Divider(
                  thickness: 0.6,
                  height: 0,
                  color: DMColors.textColor,
                ),
                SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: 'Team',
                    color: DMColors.textColor,
                    image: "assets/image/play.svg"),
                SizedBox(
                  height: 250,
                ),
                Divider(
                  thickness: 0.2,
                  height: 0,
                  color: DMColors.textColor,
                ),
                SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: 'Settings',
                    color: DMColors.textColor,
                    image: "assets/image/power.svg"),
                DrawerItem(
                    name: 'Log out',
                    color: DMColors.pinkredColor,
                    image: "assets/image/log.svg"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
