// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, must_be_immutable, library_private_types_in_public_api, unused_local_variable, avoid_print, unused_element, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unused_field, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_cubit.dart';

import '../models/user_model.dart';

class SeatListScreen extends StatefulWidget {
  final int Bus_ID;
  final int totalSeats;
  final String source;
  final String? name;
  final String dest;
  final double price;
  final String? address;
  final String Busname;
  final String email;

  const SeatListScreen({
    Key? key,
    required this.Bus_ID,
    required this.totalSeats,
    required this.source,
    this.name,
    required this.dest,
    required this.price,
    this.address,
    required this.Busname,
    required this.email,
  }) : super(key: key);

  @override
  _SeatListScreenState createState() => _SeatListScreenState();
}

class _SeatListScreenState extends State<SeatListScreen> {
  final bool _isPressed = false;
  List<bool> _selected = [];
  String referenceID = "";

  @override
  void initState() {
    super.initState();
    //_seatNumbers = List.generate(widget.totalSeats, (index) => index + 1);
    _selected = List.filled(widget.totalSeats, false);
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.Bus_ID;
    int totalSeats = widget.totalSeats;
    User user = context.read<CubitUser>().state;
    String source = widget.source;
    String? address = widget.address;
    String? name = widget.name;
    String dest = widget.dest;
    double price = widget.price;
    String Busname = widget.Busname;
    String email = widget.email;

    return RefreshIndicator(
      onRefresh: () async {
        await seatsData(id);

        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seat List'),
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
            child: FutureBuilder(
              future: seatsData(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                Widget widget;
                if (snapshot.hasData) {
                  if (_selected.isEmpty) {
                    _selected = List.filled(totalSeats, true);
                  }
                  widget = Column(
                    children: [
                      Center(
                        child: Column(
                            children: snapshot.data.map<Widget>((e) {
                          int Seat_ID = e.Seat_ID;

                          int Bus_ID = e.Bus_ID;
                          String Seat_number = e.Seat_number.toString();
                          bool available = e.available;

                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  margin: const EdgeInsets.only(top: 20),
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
                                    padding: const EdgeInsets.only(
                                        right: 6, left: 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const LabelText(
                                                name: "Seat Number :",
                                                color: DMColors.logoColor,
                                                size: 18,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'ProximaNova',
                                                textDecoration:
                                                    TextDecoration.none),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            LabelText(
                                                name: "${Seat_number}",
                                                color: DMColors.logoColor,
                                                size: 18,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'ProximaNova',
                                                textDecoration:
                                                    TextDecoration.none),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                if (available) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30))),
                                                        child: AlertDialog(
                                                          title: const Text(
                                                              'Book a Seat'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  showModalBottomSheet<
                                                                      void>(
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              12),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              12),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              30),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              30),
                                                                    )),
                                                                    backgroundColor:
                                                                        DMColors
                                                                            .backgroundColor,
                                                                    elevation:
                                                                        8.0,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Container(
                                                                        height:
                                                                            200,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: <Widget>[
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(right: 12),
                                                                                    child: GestureDetector(
                                                                                      onTap: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: const Icon(Icons.cancel_outlined),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    sendtoKhalti();

                                                                                    postKhaltibusbooking(user.name!, source, dest, user.id!, price, user.address!, Bus_ID, Busname, Seat_ID, email);

                                                                                    print("Cant Post Hotels");
                                                                                  },
                                                                                  child: Container(
                                                                                    width: double.infinity,
                                                                                    height: 58,
                                                                                    decoration: BoxDecoration(color: DMColors.violetcolor, borderRadius: BorderRadius.circular(18)),
                                                                                    child: Center(
                                                                                      child: Row(
                                                                                        children: const [
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Icon(
                                                                                            Icons.payment,
                                                                                            size: 30,
                                                                                            color: DMColors.loginColor,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 80,
                                                                                          ),
                                                                                          LabelText(name: 'Pay with Khalti', color: DMColors.loginColor, size: 20, fontWeight: FontWeight.w700, fontFamily: 'ProximaNova', textDecoration: TextDecoration.none),
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
                                                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    postbusbooking(user.name!, source, dest, user.id!, price, user.address!, Bus_ID, Busname, Seat_ID, email);
                                                                                  },
                                                                                  child: Container(
                                                                                    width: double.infinity,
                                                                                    height: 58,
                                                                                    decoration: BoxDecoration(color: DMColors.logoColor, borderRadius: BorderRadius.circular(18)),
                                                                                    child: Center(
                                                                                      child: Row(
                                                                                        children: const [
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Icon(
                                                                                            Icons.payment,
                                                                                            size: 30,
                                                                                            color: DMColors.loginColor,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 80,
                                                                                          ),
                                                                                          LabelText(name: 'Pay On Arrival', color: DMColors.loginColor, size: 20, fontWeight: FontWeight.w700, fontFamily: 'ProximaNova', textDecoration: TextDecoration.none),
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
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Book')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Cancel')),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                                // else if(
                                                //   bookingStatus == Booking Complete
                                                //   available == !available
                                                // ){}
                                                else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: AlertDialog(
                                                            title: const Text(
                                                                'Seat Unavailable'),
                                                            content: const Text(
                                                                'Seat is not Available For Booking'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Ok')),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                }
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 40),
                                            child: Container(
                                              width: double.infinity,
                                              height: 48,
                                              //color: DMColors.logoColor,
                                              decoration: BoxDecoration(
                                                color: available
                                                    ? DMColors.lightGreenColor
                                                        .withOpacity(0.7)
                                                    : Colors
                                                        .red, // when seat is not available
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Center(
                                                child: LabelText(
                                                    name: 'Book Seat',
                                                    color: DMColors.loginColor,
                                                    size: 18,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'ProximaNova',
                                                    textDecoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList()),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  widget = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 100,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Sorry, an error occurred while loading data',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Please check your internet connection and try again',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text('Retry'),
                      )
                    ],
                  );
                } else {
                  widget = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Loading...',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                }
                return widget;
              },
            ),
          ),
        ),
      ),
    );
  }

  bool paymentSuccessfull = false;

  sendtoKhalti() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "Wegster",
          productName: "Wegster Bus Seat Bookings"),
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
        msg: "Payment Successfull and Seat has been Booked",
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
      paymentSuccessfull = false;
    });
    Fluttertoast.showToast(
        msg: "Payment Cancelled",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}
