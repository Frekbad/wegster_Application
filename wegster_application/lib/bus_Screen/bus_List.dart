// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:wegster_application/api/auth/django_authentication_api.dart';

import 'package:wegster_application/bus_Screen/seat_List.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/screens/bus_Search.dart';

class BusListScreen extends StatefulWidget {
  const BusListScreen({
    Key? key,
  }) : super(key: key);
  @override
  _BusListScreenState createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        GetBus();

        setState(() {});
      },
      child: Scaffold(
        backgroundColor: DMColors.loginColor,
        appBar: AppBar(
          title: const Text('Bus List'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: SearchBus());
                },
              ),
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [DMColors.logoColor, DMColors.lightGreenColor],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: FutureBuilder<List<Bus>>(
                future: GetBus(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  Widget widget;
                  if (snapshot.hasData) {
                    widget = Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Lottie.asset('assets/image/lottie/bus.json',
                            height: 260),
                        Center(
                          child: Column(
                              children: snapshot.data.map<Widget>((e) {
                            int busId = e.Bus_ID;
                            String Busname = "${e.Busname}";
                            String source = "${e.source}";
                            String dest = "${e.dest}";
                            double price = e.price;
                            int totalSeats = e.totalSeats;
                            String email = "${e.email}";

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SeatListScreen(
                                    Bus_ID: busId,
                                    totalSeats: totalSeats,
                                    source: source,
                                    dest: dest,
                                    price: price,
                                    Busname: Busname,
                                    email: email,
                                  ),
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 10, left: 10),
                                child: Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: DMColors.logoColor
                                              .withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                          blurStyle: BlurStyle.normal,
                                          offset: const Offset(3,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      color: DMColors.loginColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(11))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Busname,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: DMColors.blackColor),
                                            ),
                                            // ignore: prefer_const_constructors
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              // ignore: prefer_const_constructors
                                              child: Text(
                                                "Starting From",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        DMColors.googleColor),
                                              ),
                                            ),
                                            // Text(
                                            //   "Rs. ${price.toString()}",
                                            // ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 23,
                                            width: 32,
                                            decoration: const BoxDecoration(
                                                color: DMColors.lightGreenColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                )),
                                            child: const Icon(
                                              Icons.star,
                                              color: DMColors.loginColor,
                                              size: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              "Rs. ${price.toString()}",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w800,
                                                  color: DMColors.redColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            source,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: DMColors.logoColor),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            'To',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: DMColors.marronColor),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            dest,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: DMColors.logoColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 20,
                                          ),
                                          Icon(
                                            Icons.usb_rounded,
                                            size: 20,
                                          ),
                                          Icon(
                                            Icons.free_breakfast_outlined,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.medical_services_outlined,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Text(
                                              'Total Seats:',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: DMColors.blackColor),
                                            ),
                                            Text(
                                              totalSeats.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: DMColors.logoColor),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList()),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            LabelText(
                                name: 'Travel more, spend less',
                                color: DMColors.blackColor,
                                size: 20,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'ProximaNova',
                                textDecoration: TextDecoration.none),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Container(
                                width: 230,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
                                      LabelText(
                                          name: 'Genius',
                                          color: DMColors.loginColor,
                                          size: 17,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'ProximaNova',
                                          textDecoration: TextDecoration.none),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          LabelText(
                                              name: 'You are at ',
                                              color: DMColors.loginColor,
                                              size: 17,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                          LabelText(
                                              name: 'Genuis Level 1 ',
                                              color: DMColors.loginColor,
                                              size: 17,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                        ],
                                      ),
                                      LabelText(
                                          name: 'in our loyalty programme ',
                                          color: DMColors.loginColor,
                                          size: 17,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'ProximaNova',
                                          textDecoration: TextDecoration.none),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 230,
                                height: 140,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5, color: DMColors.blueColor),
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      const LabelText(
                                          name: '15 % discounts',
                                          color: DMColors.blackColor,
                                          size: 17,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'ProximaNova',
                                          textDecoration: TextDecoration.none),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          LabelText(
                                              name: 'Enjoy discounts at  ',
                                              color: DMColors.blackColor,
                                              size: 17,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                          LabelText(
                                              name: 'Here ',
                                              color: DMColors.blackColor,
                                              size: 17,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                        ],
                                      ),
                                      LabelText(
                                          name: 'properties worldwide',
                                          color: DMColors.blackColor,
                                          size: 17,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'ProximaNova',
                                          textDecoration: TextDecoration.none),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 230,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: DMColors.googleColor,
                                  border: Border.all(
                                      color: DMColors.googleColor2, width: 1.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
                                      LabelText(
                                          name: '10 % discounts',
                                          color: DMColors.blackColor,
                                          size: 17,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'ProximaNova',
                                          textDecoration: TextDecoration.none),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          LabelText(
                                              name: 'Enjoy discounts at  ',
                                              color: DMColors.blackColor,
                                              size: 17,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                          LabelText(
                                              name: 'Here ',
                                              color: DMColors.blackColor,
                                              size: 17,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                        ],
                                      ),
                                      LabelText(
                                          name: 'properties worldwide',
                                          color: DMColors.blackColor,
                                          size: 17,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'ProximaNova',
                                          textDecoration: TextDecoration.none),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 230,
                                height: 140,
                                decoration: BoxDecoration(
                                    color: DMColors.backgroundColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: DMColors.googleColor,
                                        width: 1.5)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
                                      LabelText(
                                          name: 'Great Buses',
                                          color: DMColors.blackColor,
                                          size: 17,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'ProximaNova',
                                          textDecoration: TextDecoration.none),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          LabelText(
                                              name: 'Complete Relaxing  ',
                                              color: DMColors.blackColor,
                                              size: 17,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                          LabelText(
                                              name: 'and',
                                              color: DMColors.blackColor,
                                              size: 17,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                        ],
                                      ),
                                      LabelText(
                                          name: ' Friendly Staffs',
                                          color: DMColors.blackColor,
                                          size: 17,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'ProximaNova',
                                          textDecoration: TextDecoration.none),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 35,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: LabelText(
                                  name: 'Why Bus book with Wegster.com?',
                                  color: DMColors.blackColor,
                                  size: 19,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ProximaNova',
                                  textDecoration: TextDecoration.none),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        Row(
                          children: [
                            Image.asset(
                              'assets/image/support.jpg',
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const LabelText(
                                name: '24/7 Customer Support',
                                color: DMColors.blackColor,
                                size: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ProximaNova',
                                textDecoration: TextDecoration.none)
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 30),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Divider(
                                    color: DMColors.googleColor,
                                    thickness: 0.45,
                                    height: 0,
                                    indent: 11.0,
                                    //endIndent: ,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Divider(
                                    color: DMColors.googleColor,
                                    thickness: 0.45,
                                    height: 0,
                                    endIndent: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //SizedBox(height: 3),
                        Row(
                          children: [
                            Image.asset(
                              'assets/image/secure.png',
                              height: 30,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const LabelText(
                                name: 'Secure Booking Process',
                                color: DMColors.blackColor,
                                size: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ProximaNova',
                                textDecoration: TextDecoration.none)
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 30),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Divider(
                                    color: DMColors.textColor,
                                    thickness: 0.45,
                                    height: 0,
                                    indent: 11.0,
                                    //endIndent: ,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Divider(
                                    color: DMColors.textColor,
                                    thickness: 0.45,
                                    height: 0,
                                    endIndent: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/image/thumps.jpg',
                              height: 30,
                              width: 40,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const LabelText(
                                name: 'Trusted By Members',
                                color: DMColors.blackColor,
                                size: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ProximaNova',
                                textDecoration: TextDecoration.none)
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 30),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Divider(
                                    color: DMColors.textColor,
                                    thickness: 0.45,
                                    height: 0,
                                    indent: 11.0,
                                    //endIndent: ,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Divider(
                                    color: DMColors.textColor,
                                    thickness: 0.45,
                                    height: 0,
                                    endIndent: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/image/people.jpg',
                              height: 30,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const LabelText(
                                name: '11 Million Happy Members',
                                color: DMColors.blackColor,
                                size: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ProximaNova',
                                textDecoration: TextDecoration.none)
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 30),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Divider(
                                    color: DMColors.textColor,
                                    thickness: 0.45,
                                    height: 0,
                                    indent: 11.0,
                                    //endIndent: ,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Divider(
                                    color: DMColors.textColor,
                                    thickness: 0.45,
                                    height: 0,
                                    endIndent: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    widget =
                        const Center(child: Text('Error fetching bus list'));
                    //print(snapshot.error);
                  } else {
                    widget = const Center(child: CircularProgressIndicator());
                  }
                  return widget;
                }),
          ),
        ),
      ),
    );
  }
}
