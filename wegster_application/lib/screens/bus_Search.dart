// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/bus_Screen/seat_List.dart';

import '../exports/exports.dart';

class SearchBus extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  FetchBus _busList = FetchBus();

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
            child: FutureBuilder(
          future: _busList.getBusList(query: query),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget widget = const Text("");
            if (snapshot.hasData) {
              widget = Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Bus Near You")),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Column(
                        children: snapshot.data.map<Widget>((e) {
                      int Bus_ID = e.Bus_ID;
                      String Busname = "${e.Busname}";
                      String source = "${e.source}";
                      String dest = "${e.dest}";
                      double price = e.price;
                      int totalSeats = e.totalSeats;

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SeatListScreen(
                              Bus_ID: Bus_ID,
                              totalSeats: totalSeats,
                              source: source,
                              dest: dest,
                              price: price,
                              Busname: Busname,
                            ),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: DMColors.logoColor.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    blurStyle: BlurStyle.normal,
                                    offset: const Offset(
                                        3, 2), // changes position of shadow
                                  ),
                                ],
                                color: DMColors.loginColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(11))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        // ignore: prefer_const_constructors
                                        child: Text(
                                          "Starting From",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: DMColors.googleColor),
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
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        height: 23,
                                        width: 32,
                                        decoration: const BoxDecoration(
                                            color: DMColors.lightGreenColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            )),
                                        child: const Icon(
                                          Icons.star,
                                          color: DMColors.loginColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
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
                                    const SizedBox(
                                      width: 4,
                                    ),
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
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                    height: 20,
                  )
                ],
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search Bus'),
    );
  }
}
