// ignore_for_file: non_constant_identifier_names, avoid_print, unused_local_variable, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/widgets/constants.dart';
import 'package:http/http.dart' as http;

class HotelBookDetails extends StatefulWidget {
  const HotelBookDetails({super.key});

  @override
  State<HotelBookDetails> createState() => _HotelBookDetailsState();
}

class _HotelBookDetailsState extends State<HotelBookDetails> {
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

    // ignore: prefer_const_constructors
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
          backgroundColor: DMColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: DMColors.logoColor,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 27,
                    color: DMColors.backgroundwhiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 65),
                  child: Text("Rooms Booking",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'ProximaNova',
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          color: DMColors.backgroundwhiteColor)),
                ),
                Icon(
                  Icons.bookmark,
                  size: 24,
                  color: DMColors.backgroundwhiteColor,
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: FutureBuilder(
              future: GetVendorHotelOrder(id),
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
                    if (snapshot.hasData && snapshot.data.isEmpty) {
                      widget = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                          ),
                          Center(
                            child: Lottie.asset('assets/image/nodata.json',
                                height: 220, width: 250),
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
                              int id = e.id;
                              String Room_Type = "${e.Room_Type}";
                              String Bed_Type = "${e.Bed_Type}";
                              String price_per_night = "${e.price_per_night}";
                              String Refundable_Option = e.Refundable_Option;
                              int User_ID = e.user;
                              String name = "${e.name}";
                              String address = "${e.address}";
                              String Hotel_email = "${e.Hotel_Email}";
                              String HotelName = "${e.HotelName}";
                              String Hotel_Location = "${e.Hotel_Location}";
                              String Order_Status = "${e.Order_Status}";

                              int Hotel_ID = e.Hotel_ID;
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
                                                          String orderStatus =
                                                              "Booking_completed";
                                                          int Hotel_ID =
                                                              user.id!;
                                                          int userID = User_ID;
                                                          String Message =
                                                              "Your Booking ${id} for ${HotelName} has been Accepted, \nWegster";
                                                          BookingUpdateHotel(
                                                              id,
                                                              orderStatus,
                                                              Hotel_ID,
                                                              userID,
                                                              Hotel_email,
                                                              Message);

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'ACCEPT')),
                                                    TextButton(
                                                        onPressed: () {
                                                          String orderStatus =
                                                              "Booking_Canceled";
                                                          int Hotel_ID =
                                                              user.id!;
                                                          int userID = User_ID;
                                                          String Message =
                                                              "Your Room Booking ${id} for ${HotelName} has been cancelled, \nWegster";

                                                          BookingUpdateHotel(
                                                              id,
                                                              orderStatus,
                                                              Hotel_ID,
                                                              userID,
                                                              Hotel_email,
                                                              Message);
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
                                                      'assets/image/hotelbooking.jpg'),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${HotelName}",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontFamily:
                                                              'ProximaNova',
                                                          color: DMColors
                                                              .blackColor),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Booking ID: ${id}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontFamily:
                                                              'ProximaNova',
                                                          color: DMColors
                                                              .blackColor),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${HotelName}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontFamily:
                                                              'ProximaNova',
                                                          color: DMColors
                                                              .blackColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${Order_Status}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'ProximaNova',
                                                  color: DMColors.blackColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Rs. ${price_per_night}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontFamily: 'ProximaNova',
                                                      color: DMColors.redColor),
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

  Future<dynamic> BookingUpdateHotel(int id, String Order_Status, int Hotel_ID,
      int User_ID, String email, String message) async {
    String HotelID = Hotel_ID.toString();
    String userid = User_ID.toString();
    Map body = {
      "Order_Status": Order_Status,
      "Hotel_ID": HotelID,
      "user": userid
    };
    String order_ID = id.toString();

    var url = Uri.parse("$baseUrl/user/RoomBook/$order_ID");
    var res = await http.put(url, body: body);
    //var res = await http.put(Uri.parse(api + order_ID, body: body));

    print(res.body);
    print(res.statusCode);

    if (res.statusCode == 200 || res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Order Status has been updated",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      GetCustomerOrder(Hotel_ID);
      HotelBookingNotificationSend(email, message);

      //postRestaurantNotification(Email, Message);

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
