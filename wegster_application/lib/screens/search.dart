// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/widgets/search_container.dart';

import '../widgets/todo_container.dart';
import 'home_display.dart';

class SearchUser extends SearchDelegate {
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

  FetchUser _dealList = FetchUser();

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
            child: FutureBuilder(
          future: _dealList.getUserList(query: query),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget widget = const Text("");

            if (snapshot.hasData) {
              if (snapshot.hasData && snapshot.data.isEmpty) {
                widget = Column(
                  children: [
                    const SizedBox(
                      height: 125,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: Lottie.asset('assets/image/lottie/data.json'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "No Hotel Found",
                      style: TextStyle(
                          fontSize: 18,
                          color: DMColors.blackColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                );
              } else {
                widget = Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Column(
                          children: snapshot.data.map<Widget>((e) {
                        int Hotel_ID = e.Hotel_ID;
                        String Hotel_Token = "${e.Hotel_Token}";
                        String Hotel_Email = "${e.Hotel_Email}";
                        String Hotel_Name = "${e.Hotel_Name}";
                        String Hotel_Location = "${e.Hotel_Location}";
                        String Hotel_Image = "${e.Hotel_Image}";
                        String Hotel_Price = "${e.Hotel_Price}";
                        String Hotel_Description = "${e.Hotel_Description}";

                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => HotelPageDisplay(
                                            Hotel_Name: Hotel_Name,
                                            Hotel_Email: Hotel_Email,
                                            Hotel_Location: Hotel_Location,
                                            Hotel_Image: Hotel_Image,
                                            Hotel_Price: Hotel_Price,
                                            Hotel_Description:
                                                Hotel_Description,
                                            Hotel_ID: Hotel_ID,
                                            //Room_Id: Room_Id,
                                          )));
                            },
                            child: SearchContainer(
                                Hotel_Email: Hotel_Email,
                                Hotel_ID: Hotel_ID,
                                Hotel_Image: Hotel_Image,
                                Hotel_Location: Hotel_Location,
                                Hotel_Name: Hotel_Name,
                                Hotel_Token: Hotel_Token,
                                Hotel_Price: Hotel_Price,
                                Hotel_Description: Hotel_Description));
                      }).toList()),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              }
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search Hotels'),
    );
  }
}
