import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wegster_application/screens/help_support.dart';
import 'package:wegster_application/screens/home_page.dart';
import 'package:wegster_application/screens/my_account.dart';
import 'package:wegster_application/screens/my_bookings.dart';
import '../exports/exports.dart';

class ButtonNavigation extends StatefulWidget {
  const ButtonNavigation({Key? key, this.user}) : super(key: key);
  final GoogleSignInAccount? user;

  @override
  State<ButtonNavigation> createState() => _ButtonNavigationState();
}

class _ButtonNavigationState extends State<ButtonNavigation> {
  int _currentIndex = 0;
  //late GoogleSignInAccount user = widget.user;

  late List<Widget> screen = <Widget>[
    const Home(),
    const MyBooking(),
    const MyAccount(),
    const HelpSupport(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screen,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        height: size.width * .235,
        decoration: BoxDecoration(
          color: DMColors.loginColor,
          boxShadow: [
            BoxShadow(
              color: tabColors.elementAt(_currentIndex).withOpacity(.10),
              blurRadius: 30,
              offset: const Offset(-10, 3),
            ),
          ],
          // borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            selectedIndex: _currentIndex,
            onTabChange: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            hoverColor: tabColors.elementAt(_currentIndex).withOpacity(0.6),
            activeColor: tabColors.elementAt(_currentIndex),
            tabBackgroundColor:
                tabColors.elementAt(_currentIndex).withOpacity(0.1),
            gap: 8,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                iconColor: DMColors.purpleColor,
                text: 'Home',
                //hoverColor: Colors.deepOrange,
              ),
              GButton(
                icon: Icons.bookmark_sharp,
                iconColor: DMColors.redColor,
                text: 'My Booking',
              ),
              GButton(
                icon: Icons.person_rounded,
                iconColor: DMColors.logoColor,
                text: 'My Account',
              ),
              GButton(
                icon: Icons.help_outlined,
                iconColor: DMColors.greenColor,
                text: 'Help and Support',
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import '../exports/exports.dart';

// void main() {
//   runApp(const ButtonNavigation());
// }

// class ButtonNavigation extends StatefulWidget {
//   const ButtonNavigation({super.key});

//   @override
//   State<ButtonNavigation> createState() => _ButtonNavigationState();
// }

// class _ButtonNavigationState extends State<ButtonNavigation> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: PageList[_currentIndex],
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
//         height: size.width * .235,
//         decoration: BoxDecoration(
//           color: DMColors.loginColor,
//           boxShadow: [
//             BoxShadow(
//               color: tabColors.elementAt(_currentIndex).withOpacity(.10),
//               blurRadius: 30,
//               offset: const Offset(-10, 3),
//             ),
//           ],
//           // borderRadius: BorderRadius.circular(30),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
//           child: GNav(
//             selectedIndex: _currentIndex,
//             onTabChange: (newIndex) {
//               setState(() {
//                 _currentIndex = newIndex;
//               });
//             },
//             hoverColor: tabColors.elementAt(_currentIndex).withOpacity(0.6),
//             activeColor: tabColors.elementAt(_currentIndex),
//             tabBackgroundColor:
//                 tabColors.elementAt(_currentIndex).withOpacity(0.1),
//             gap: 8,
//             padding: const EdgeInsets.all(16),
//             tabs: const [
//               GButton(
//                 icon: Icons.home,
//                 iconColor: DMColors.purpleColor,
//                 text: 'Home',
//                 //hoverColor: Colors.deepOrange,
//               ),
//               GButton(
//                 icon: Icons.bookmark_sharp,
//                 iconColor: DMColors.redColor,
//                 text: 'My Booking',
//               ),
//               GButton(
//                 icon: Icons.person_rounded,
//                 iconColor: DMColors.logoColor,
//                 text: 'My Account',
//               ),
//               GButton(
//                 icon: Icons.help_outlined,
//                 iconColor: DMColors.greenColor,
//                 text: 'Help and Support',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
