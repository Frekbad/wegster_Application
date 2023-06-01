// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold);

    final style2 = TextStyle(
        fontSize: 19, color: Colors.grey[800], fontWeight: FontWeight.w600);

    final style3 = TextStyle(
      fontSize: 16,
      color: Colors.grey[700],
    );

    final style4 = const TextStyle(
      fontSize: 14,
      color: Colors.black87,
    );

    final style5 = TextStyle(
      fontSize: 14,
      color: Colors.grey[600],
    );

    final style6 = TextStyle(
      fontSize: 12,
      color: Colors.grey[800],
    );

    final style8 = TextStyle(
        fontSize: 14, color: Colors.purple[600], fontStyle: FontStyle.italic);

    final style7 = const TextStyle(
      fontSize: 14,
      color: Colors.black87,
    );

    final style9 = TextStyle(
        fontSize: 16, color: Colors.purple[600], fontWeight: FontWeight.w500);

    User user = context.read<CubitUser>().state;
    int id = user.id!;

    return RefreshIndicator(
        onRefresh: () async {
          GetCustomerOrder(id);

          setState(() {});
        },
        child: Scaffold(
          backgroundColor: DMColors.loginColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: DMColors.logoColor,
            automaticallyImplyLeading: false,
            title: const Text(
              "MY HOTEL BOOKING",
              // style: GoogleFonts.lato(
              //   textStyle: style,
              // ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: FutureBuilder(
              future: GetCustomerOrder(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Widget widget = const Text("");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.hasData && snapshot.data.isEmpty) {
                      widget = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Center(
                            child: Lottie.asset(
                                'assets/image/lottie/nodata.json',
                                height: 350,
                                width: 500),
                          ),
                        ],
                      );
                    } else {
                      widget = Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Lottie.asset('assets/image/lottie/book.json',
                              height: 150, width: 300),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Column(
                                children: snapshot.data.map<Widget>((e) {
                              int Hotel_ID = e.Hotel_ID;
                              String price_per_night = "${e.price_per_night}";
                              String HotelName = "${e.HotelName}";
                              String Hotel_Location = e.Hotel_Location;
                              String Bed_Type = "${e.Bed_Type}";
                              String Room_Type = "${e.Room_Type}";

                              String Hotel_Email = "${e.Hotel_Email}";
                              int user = e.user;
                              String Order_Status = "${e.Order_Status}";

                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: DMColors.logoColor
                                              .withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          blurStyle: BlurStyle.normal,
                                          offset: const Offset(3,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      color: DMColors.loginColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(11))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 35,
                                            backgroundImage: AssetImage(
                                              'assets/image/3.jpg',
                                            ),
                                            backgroundColor:
                                                DMColors.loginColor,
                                            //foregroundColor: DMColors.logoColor,
                                          ),
                                          const SizedBox(
                                            width: 45,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Text(
                                                  "${HotelName}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Order_Status ==
                                                              'Booking_completed'
                                                          ? DMColors.blackColor
                                                          : DMColors.redColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${Room_Type}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Order_Status ==
                                                            'Booking_completed'
                                                        ? DMColors.blackColor
                                                        : DMColors.redColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              "Rs ${price_per_night}",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Order_Status ==
                                                        'Booking_completed'
                                                    ? DMColors.lightGreenColor
                                                    : DMColors.redColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              "${Order_Status}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Order_Status ==
                                                          'Booking_completed'
                                                      ? DMColors.lightGreenColor
                                                      : DMColors.redColor,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList()),
                          ),
                        ],
                      );
                    }
                  } else {
                    widget = const Center(child: Text("NO DATA"));
                  }
                }

                return widget;
              },
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
