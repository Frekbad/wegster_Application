// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api, non_constant_identifier_names, sized_box_for_whitespace
// ignore_for_file: non_constant_identifier_names, unused_local_variable, duplicate_ignore, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../models/user_cubit.dart';

class RoomBooking extends StatefulWidget {
  final int Hotel_ID;

  //final String Hotel_email;
  final String HotelName;
  final String Hotel_Location;

  const RoomBooking({
    Key? key,
    required this.Hotel_ID,

    //required this.Hotel_email,
    required this.HotelName,
    required this.Hotel_Location,
  }) : super(key: key);

  @override
  State<RoomBooking> createState() => _RoomBookingState();
}

class _RoomBookingState extends State<RoomBooking> {
  String referenceID = "";
  @override
  Widget build(BuildContext context) {
    int id = widget.Hotel_ID;

    //String Hotel_Email = widget.Hotel_email;
    String HotelName = widget.HotelName;
    String Hotel_Location = widget.Hotel_Location;
    User user = context.read<CubitUser>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DMColors.logoColor,
        title: const LabelText(
            name: 'Choose Your Stay',
            color: DMColors.loginColor,
            size: 21,
            fontWeight: FontWeight.w800,
            fontFamily: 'ProximaNova',
            textDecoration: TextDecoration.none),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: FutureBuilder(
          future: RoomsData(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget widget = const Text("");
            if (snapshot.hasData) {
              widget = Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  // Divider(
                  //   color: Colors.grey.shade300,
                  //   thickness: 2,
                  // ),
                  Center(
                    child: Column(
                        children: snapshot.data.map<Widget>((e) {
                      int Hotel_ID = e.Hotel_ID;
                      int Room_Id = e.Room_ID;
                      String Room_Type = "${e.Room_Type}";
                      String Bed_Type = "${e.Bed_Type}";
                      String Refundable_Option = "${e.Refundable_Option}";
                      String price_per_night = "${e.price_per_night}";

                      return Column(
                        children: [
                          const SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 320,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 6, left: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LabelText(
                                            name: "${Room_Type}",
                                            color: DMColors.logoColor,
                                            size: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                        const Icon(
                                          Icons.bookmark,
                                          color: DMColors.logoColor,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: const [
                                        LabelText(
                                            name: 'Price for :',
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.person,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.bed,
                                          size: 17,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        LabelText(
                                            name: "${Bed_Type}",
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.credit_card_off_outlined,
                                          size: 17,
                                          color: DMColors.darkgreenColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        LabelText(
                                            name: 'No Credit card needed',
                                            color: DMColors.darkgreenColor,
                                            size: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.coffee,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        LabelText(
                                            name: 'BreakFast Available',
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.balcony,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        LabelText(
                                            name: 'Balcony',
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        LabelText(
                                            name: 'View',
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          Icons.bathroom_outlined,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        LabelText(
                                            name: 'Ensuite bathroom',
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.lightbulb_rounded,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        LabelText(
                                            name: 'Tip:',
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        LabelText(
                                            name:
                                                'This room is bigger than most in Birtamod',
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const LabelText(
                                            name: 'Price ',
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        LabelText(
                                            name: price_per_night,
                                            color: DMColors.blackColor,
                                            size: 15,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                        const SizedBox(
                                          width: 120,
                                        ),
                                        LabelText(
                                            name: Refundable_Option,
                                            color: DMColors.marronColor,
                                            size: 17,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'ProximaNova',
                                            textDecoration:
                                                TextDecoration.none),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          )),
                                          backgroundColor:
                                              DMColors.backgroundColor,
                                          elevation: 8.0,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 200,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 12),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Icon(Icons
                                                                .cancel_outlined),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (paymentSuccessful) {
                                                            sendtoKhalti();
                                                            posthotelKhaltibooking(
                                                                Room_Type,
                                                                Bed_Type,
                                                                price_per_night,
                                                                Refundable_Option,
                                                                user.id!,
                                                                user.name!,
                                                                user.address!,
                                                                user.email!,
                                                                HotelName,
                                                                Hotel_Location,
                                                                id);
                                                            // Navigator.pop(
                                                            //     context);
                                                          } else {
                                                            print(
                                                                "cant post Hotel");
                                                          }
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 58,
                                                          decoration: BoxDecoration(
                                                              color: DMColors
                                                                  .violetcolor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18)),
                                                          child: Center(
                                                            child: Row(
                                                              // ignore: prefer_const_literals_to_create_immutables
                                                              children: [
                                                                // ignore: prefer_const_constructors
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                const Icon(
                                                                  Icons.payment,
                                                                  size: 30,
                                                                  color: DMColors
                                                                      .loginColor,
                                                                ),
                                                                const SizedBox(
                                                                  width: 80,
                                                                ),
                                                                const LabelText(
                                                                    name:
                                                                        'Pay with Khalti',
                                                                    color: DMColors
                                                                        .loginColor,
                                                                    size: 20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontFamily:
                                                                        'ProximaNova',
                                                                    textDecoration:
                                                                        TextDecoration
                                                                            .none),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          posthotelbooking(
                                                              Room_Type,
                                                              Bed_Type,
                                                              price_per_night,
                                                              Refundable_Option,
                                                              user.id!,
                                                              user.name!,
                                                              user.address!,
                                                              user.email!,
                                                              HotelName,
                                                              Hotel_Location,
                                                              id);
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 58,
                                                          decoration: BoxDecoration(
                                                              color: DMColors
                                                                  .logoColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18)),
                                                          child: Center(
                                                            child: Row(
                                                              children: const [
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Icon(
                                                                  Icons.payment,
                                                                  size: 30,
                                                                  color: DMColors
                                                                      .loginColor,
                                                                ),
                                                                SizedBox(
                                                                  width: 80,
                                                                ),
                                                                LabelText(
                                                                    name:
                                                                        'Pay On Arrival',
                                                                    color: DMColors
                                                                        .loginColor,
                                                                    size: 20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontFamily:
                                                                        'ProximaNova',
                                                                    textDecoration:
                                                                        TextDecoration
                                                                            .none),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                        // posthotelbooking(
                                        //     Room_Type,
                                        //     Bed_Type,
                                        //     price_per_night,
                                        //     Refundable_Option,
                                        //     user.id!,
                                        //     user.name!,
                                        //     user.address!,
                                        //     Hotel_Email,
                                        //     HotelName,
                                        //     Hotel_Location,
                                        //     id);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 48,
                                        color: DMColors.logoColor,
                                        child: const Center(
                                          child: LabelText(
                                              name: 'Book',
                                              color: DMColors.loginColor,
                                              size: 18,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'ProximaNova',
                                              textDecoration:
                                                  TextDecoration.none),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 21,
                          ),
                        ],
                      );
                    }).toList()),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              widget = const Center(
                child: Text("Something went wrong"),
              );
            } else {
              widget = const Center(
                child: CircularProgressIndicator(),
              );
            }
            return widget;
          },
        )),
      ),
    );
  }

  bool paymentSuccessful = true;

  sendtoKhalti() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "Wegster",
          productName: "Wegster Hotel Bookings"),
      preferences: [
        PaymentPreference.khalti,
        PaymentPreference.eBanking,
        PaymentPreference.connectIPS,
        PaymentPreference.mobileBanking,
        PaymentPreference.sct
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    Fluttertoast.showToast(
        msg: "Payment Successfull And Room Has been Booked ",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: DMColors.lightGreenColor,
        textColor: Colors.white);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Payment successfull"),
          actions: [
            SimpleDialogOption(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  referenceID = success.idx;
                  paymentSuccessful = true;
                });
              },
            )
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
    Fluttertoast.showToast(
        msg: "Payment Failed",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void onCancel() {
    debugPrint("cancelled");
    setState(() {
      paymentSuccessful = false;
    });
    Fluttertoast.showToast(
        msg: "Payment Cancelled",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}
