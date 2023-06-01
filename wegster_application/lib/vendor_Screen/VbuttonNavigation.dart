import 'package:flutter/material.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/vendor_Screen/detailsroom.dart';
import 'package:wegster_application/vendor_Screen/hotelDashboard.dart';

class VButtonNavigation extends StatefulWidget {
  const VButtonNavigation({super.key});

  @override
  State<VButtonNavigation> createState() => _VButtonNavigationState();
}

class _VButtonNavigationState extends State<VButtonNavigation> {
  var currentIndex = 0;
  List<Widget> screens = <Widget>[
    const HotelDashboard(),
    const VendorMenuItems(),
  ];
  List<IconData> listOfIcons = [
    Icons.home,
    Icons.add_box_outlined,
  ];

  List<String> labels = [
    "Home",
    "Details",
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        height: 78,
        decoration: BoxDecoration(
          color: DMColors.logoColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: DMColors.blackColor.withOpacity(.3),
            )
          ],
        ),
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: (size.width * .24)),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  currentIndex = index;
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1400),
                    curve: Curves.easeIn,
                    margin: EdgeInsets.only(
                      bottom: index == currentIndex ? 0 : size.width * .039,
                      right: size.width * .0500,
                      left: size.width * .0700,
                    ),
                    width: size.width * .118,
                    height: index == currentIndex ? size.width * .014 : 0,
                    decoration: const BoxDecoration(
                      color: DMColors.loginColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                  ),
                  Icon(listOfIcons[index],
                      size: size.width * .076, color: DMColors.loginColor),
                  Text(
                    labels[index],
                    style: const TextStyle(
                        color: DMColors.loginColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),

                    //style: GoogleFonts.lato(color: Colors.purple),
                  ),
                  SizedBox(height: size.width * .03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
