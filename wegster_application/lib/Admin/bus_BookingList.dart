// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/screens/onboard_screen.dart';
import 'package:wegster_application/screens/welcome_page.dart';
import 'package:wegster_application/widgets/constants.dart';

import '../exports/exports.dart';
import '../models/user_cubit.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class BusBookingList extends StatefulWidget {
  const BusBookingList({super.key});

  @override
  State<BusBookingList> createState() => _BusBookingListState();
}

class _BusBookingListState extends State<BusBookingList> {
  @override
  // ignore: duplicate_ignore
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold);

    final style2 = TextStyle(
        fontSize: 19, color: Colors.grey[800], fontWeight: FontWeight.w600);

    final style3 = TextStyle(
      fontSize: 16,
      color: Colors.grey[700],
    );

    final style4 = TextStyle(
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

    final style7 = TextStyle(
      fontSize: 14,
      color: Colors.black87,
    );

    final style9 = TextStyle(
        fontSize: 16, color: Colors.purple[600], fontWeight: FontWeight.w500);

    User user = context.read<CubitUser>().state;
    int id = user.id!;

    return RefreshIndicator(
        onRefresh: () async {
          //GetVendorOrder(id);

          setState(() {});
        },
        child: Scaffold(
          backgroundColor: DMColors.backgroundwhiteColor,
          appBar: AppBar(
            backgroundColor: DMColors.logoColor,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 100),
                  child: Text("Admin Page",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'ProximaNova',
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          color: DMColors.backgroundwhiteColor)),
                ),
                GestureDetector(
                  onTap: () async {
                    await logoutUser(user.token!);
                    // ignore: use_build_context_synchronously
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
                                          builder: (context) =>
                                              const WelcomeScreen(),
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
                  child: Icon(
                    Icons.logout_rounded,
                    size: 28,
                    color: DMColors.backgroundwhiteColor,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: FutureBuilder(
              future: GetBusadmin(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Widget widget = Text("");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      print(snapshot);
                      widget = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          Center(
                            child: Lottie.asset(
                                'assets/image/lottie/nodata.json',
                                height: 220,
                                width: 250),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Sorry! You don't have any Booking",
                            style: TextStyle(
                                color: DMColors.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      );
                    } else {
                      widget = Column(
                        children: [
                          Center(
                            child: Column(
                                children: snapshot.data.map<Widget>((e) {
                              int orderId = e.id;
                              //int id = e.id;
                              int busId = e.Bus_ID;
                              String name = "${e.name}";
                              String price = "${e.price}";
                              String orderStatus = "${e.Order_Status}";
                              String source = "${e.source}";

                              String dest = "${e.dest}";
                              int userId = e.user;

                              String address = "${e.address}";

                              String Busname = "${e.Busname}";

                              int seatId = e.Seat_ID ?? 0;
                              String email = "dhakalayush44@gmail.com";
                              String payment = "${e.Payment}";
                              //String Customer_Email = "${e.Customer_Email}";

                              return Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Text(
                                                      'Booking List'),
                                                  content: const Text(
                                                      'Do you want to Accept the Booking?'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          print(orderId);

                                                          String orderStatus =
                                                              "Booking_completed";
                                                          int BusId = busId;
                                                          int userID = userId;
                                                          String Message =
                                                              "Dear $name,Your Bus Booking $orderId for $Busname from $source to $dest has been Accepted,Please Bring Booking id while Arriving. Thank you. \nWegster";
                                                          BookingUpdateBus(
                                                              orderId,
                                                              orderStatus,
                                                              BusId,
                                                              userID,
                                                              //Hotel_email,
                                                              Message,
                                                              email);

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'ACCEPT')),
                                                    TextButton(
                                                        onPressed: () {
                                                          String orderStatus =
                                                              "Booking_Canceled";
                                                          int BusId = busId;
                                                          int userID = userId;
                                                          String Message =
                                                              "Dear $name,Your Bus Booking $orderId for $Busname from $source to $dest has been Cancelled, \nWegster";

                                                          BookingUpdateBus(
                                                              orderId,
                                                              orderStatus,
                                                              BusId,
                                                              userID,
                                                              Message,
                                                              email);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'DECLINE'))
                                                  ],
                                                ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 25,
                                            bottom: 15,
                                            top: 15),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: DMColors.logoColor
                                                  .withOpacity(0.7),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(1,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10),
                                              bottom: Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage: AssetImage(
                                                      'assets/image/BusBooking.jpg'),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Busname,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontFamily:
                                                            'ProximaNova',
                                                        color: orderStatus ==
                                                                'Booking_completed'
                                                            ? DMColors
                                                                .blackColor
                                                            : DMColors.redColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Booking ID: $orderId",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontFamily:
                                                            'ProximaNova',
                                                        color: orderStatus ==
                                                                'Booking_completed'
                                                            ? DMColors
                                                                .blackColor
                                                            : DMColors.redColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 70),
                                                      child: Text(
                                                        "Guest: $name",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontFamily:
                                                              'ProximaNova',
                                                          color: orderStatus ==
                                                                  'Booking_completed'
                                                              ? DMColors
                                                                  .logoColor
                                                              : DMColors
                                                                  .redColor,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              orderStatus,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'ProximaNova',
                                                color: orderStatus ==
                                                        'Booking_completed'
                                                    ? DMColors.logoColor
                                                    : DMColors.redColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Payment Type: $payment",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'ProximaNova',
                                                color: payment == 'khalti'
                                                    ? DMColors.violetcolor
                                                    : DMColors.logoColor,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Rs. $price",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: 'ProximaNova',
                                                    color: orderStatus ==
                                                            'Booking_completed'
                                                        ? DMColors.logoColor
                                                        : DMColors.redColor,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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

  Future<dynamic> BookingUpdateBus(int eid, String orderStatus, int busID,
      int userId, String message, String email) async {
    String BusID = busID.toString();
    String userid = userId.toString();
    Map body = {"Order_Status": orderStatus, "user": userid};

    var url = Uri.parse("$baseUrl/user/BusBook/$eid");
    var res = await http.put(url, body: body);
    //var res = await http.put(Uri.parse(api + order_ID, body: body));

    print(res.body);
    print(res.statusCode);

    if (res.statusCode == 200 || res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Booking Status has been updated",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      GetBusadmin();
      HotelBookingNotificationSend(email, message);

      setState(() {});
    } else {
      Fluttertoast.showToast(
          msg: "Sorry! Something went wrong",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      print("Sorry");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
