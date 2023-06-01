// ignore_for_file: unused_label, non_constant_identifier_names, unused_local_variable, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_cubit.dart';

import 'package:wegster_application/widgets/search_container.dart';

import '../models/user_model.dart';

class HotelDashboard extends StatefulWidget {
  const HotelDashboard({super.key});

  @override
  State<HotelDashboard> createState() => _HotelDashboardState();
}

class _HotelDashboardState extends State<HotelDashboard> {
  @override
  Widget build(BuildContext context) {
    User user = context.read<CubitUser>().state;

    final style = TextStyle(
        fontSize: 19, color: Colors.grey[900], fontWeight: FontWeight.w800);

    final style2 = TextStyle(
        fontSize: 19, color: Colors.grey[700], fontWeight: FontWeight.w600);

    final style3 = TextStyle(
        fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.w800);

    double height = MediaQuery.of(context).size.height * 0.8;
    double width = MediaQuery.of(context).size.height * 1;
    int id = user.id!;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70), // Set this height
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: DMColors.logoColor,
                boxShadow: [
                  BoxShadow(
                    color: DMColors.marronColor.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(5, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: DMColors.loginColor,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 115),
                          child: Text(
                            " Hotel Dashboard",
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'ProximaNova',
                                fontWeight: FontWeight.w800,
                                color: DMColors.loginColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<Hotel?>(
            future: getVendor(user.id!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String? Hotel__Name = snapshot.data!.Hotel_Name;
                String? Hotel_Email = snapshot.data!.Hotel_Email;
                int? Hotel_ID = snapshot.data!.Hotel_ID;
                String? Hotel_Location = snapshot.data!.Hotel_Location;
                String? Hotel_Token = snapshot.data!.Hotel_Token;
                String? Hotel_Image = snapshot.data!.Hotel_Image;
                //int? Hotel_Price = snapshot.data!.Hotel_Price;
                String? Hotel_Description = snapshot.data!.Hotel_Description;
                return Column(children: [
                  // Lottie.asset('assets/image/lottie/hotelvendor.json',
                  //     height: 150, width: 300),
                  Container(
                    height: height,
                    width: width,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 100, left: 10, right: 10),
                          child: Container(
                            height: height,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1.8,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 2) // changes position of shadow
                                    ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  const Text(
                                    "Added Hotel Details",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'ProximaNova'),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context)
                                            //     .pushReplacement(
                                            //         MaterialPageRoute(
                                            //   builder: (context) =>
                                            //       const HotelRoomPage(),
                                            // ));
                                          },
                                          child: SearchContainer(
                                            Hotel_Description:
                                                Hotel_Description!,
                                            Hotel_Email: Hotel_Email!,
                                            Hotel_ID: Hotel_ID!,
                                            Hotel_Image: Hotel_Image!,
                                            Hotel_Location: Hotel_Location!,
                                            Hotel_Name: Hotel__Name!,
                                            //Hotel_Price: Hotel_Price.toString(),
                                            Hotel_Token: Hotel_Token!,
                                          )))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 65),
                          child: Column(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(Hotel_Image),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                Hotel__Name,
                                style: const TextStyle(
                                    fontFamily: 'ProximaNova',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: DMColors.blackColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
