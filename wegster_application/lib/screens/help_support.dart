// ignore_for_file: unused_local_variable, prefer_const_declarations, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';

import '../models/user_cubit.dart';
import '../models/user_model.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
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
          GetUserBusBooking(id);

          setState(() {});
        },
        child: Scaffold(
          backgroundColor: DMColors.loginColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: DMColors.logoColor,
            automaticallyImplyLeading: false,
            title: const Text(
              "MY BUS BOOKING",
              // style: GoogleFonts.lato(
              //   textStyle: style,
              // ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: FutureBuilder(
              future: GetUserBusBooking(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Widget widget = const Text("");
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
                              int Bus_ID = e.Bus_ID;
                              String price = "${e.price}";
                              String source = "${e.source}";
                              String dest = "${e.dest}";

                              int user = e.user;
                              String Order_Status = "${e.Order_Status}";
                              String Busname = "${e.Busname}";

                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 30),
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
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${Busname}",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: DMColors.blackColor),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    source,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            DMColors.logoColor),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    'To',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: DMColors
                                                            .marronColor),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    dest,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            DMColors.logoColor),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 20,
                                                      color: DMColors.redColor,
                                                    ),
                                                    Icon(
                                                      Icons.usb_rounded,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .free_breakfast_outlined,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .medical_services_outlined,
                                                      size: 20,
                                                      color:
                                                          DMColors.greenColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              "Rs ${price}",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: DMColors.redColor),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              "${Order_Status}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors
                                                      .greenAccent.shade400,
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
}
