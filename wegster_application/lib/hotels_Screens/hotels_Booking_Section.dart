import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wegster_application/exports/exports.dart';

class HBookingSection extends StatefulWidget {
  const HBookingSection({super.key});

  @override
  State<HBookingSection> createState() => _HBookingSectionState();
}

class _HBookingSectionState extends State<HBookingSection> {
  var _value = "-1";
  late TextEditingController dateconfirmController;
  @override
  void initState() {
    super.initState();

    dateconfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    dateconfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMColors.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DMColors.logoColor,
        title: const Padding(
          padding: EdgeInsets.only(left: 55),
          child: LabelText(
              name: 'Wegster.com',
              color: DMColors.loginColor,
              size: 23,
              fontWeight: FontWeight.w700,
              fontFamily: 'ProximaNova',
              textDecoration: TextDecoration.none),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LabelText(
                    name: 'SAME HOTEL,',
                    color: DMColors.blackColor,
                    size: 15,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none),
                LabelText(
                    name: ' CHEAPEST PRICE,',
                    color: DMColors.marronColor,
                    size: 15,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none),
                LabelText(
                    name: ' GUARANTEED!,',
                    color: DMColors.blackColor,
                    size: 15,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'ProximaNova',
                    textDecoration: TextDecoration.none),
              ],
            ),
            const SizedBox(height: 50),

            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                //border: Border.all(color: DMColors.blueColor),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Enter Your destination ',
                        hintStyle: const TextStyle(
                            color: DMColors.blackColor,
                            fontWeight: FontWeight.w500),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                              color: DMColors.logoColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: DMColors.logoColor,
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: dateconfirmController,
                      onTap: () async {
                        DateTime? showDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2700));

                        if (showDate != null) {
                          setState(() {
                            dateconfirmController.text =
                                DateFormat('yyyy-MM-dd').format(showDate);
                          });
                        }
                      },
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month),
                        hintText: 'Check IN ',
                        hintStyle: const TextStyle(
                            color: DMColors.blackColor,
                            fontWeight: FontWeight.w500),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                              color: DMColors.blackColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: DMColors.logoColor,
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: dateconfirmController,
                      onTap: () async {
                        DateTime? showDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2700));

                        if (showDate != null) {
                          setState(() {
                            dateconfirmController.text =
                                DateFormat('yyyy-MM-dd').format(showDate);
                          });
                        }
                      },
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month),
                        hintText: 'Check Out ',
                        hintStyle: const TextStyle(
                            color: DMColors.blackColor,
                            fontWeight: FontWeight.w500),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                              color: DMColors.logoColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: DMColors.logoColor,
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // child: TextFormField(
              //   controller: dateconfirmController,
              //   onTap: () async {
              //     DateTime? showDate = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate: DateTime(1990),
              //         lastDate: DateTime(2700));

              //     if (showDate != null) {
              //       setState(() {
              //         dateconfirmController.text =
              //             DateFormat('yyyy-MM-dd').format(showDate);
              //       });
              //     }
              //   },
              //   // decoration: const InputDecoration(

              //   //   labelText: 'CHECK_IN'),
              // ),
            )
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 20),
            //       child: SizedBox(
            //         width: double.infinity,
            //         child: TextFormField(
            //           controller: dateconfirmController,
            //           onTap: () async {
            //             DateTime? showDate = await showDatePicker(
            //                 context: context,
            //                 initialDate: DateTime.now(),
            //                 firstDate: DateTime(1990),
            //                 lastDate: DateTime(2700));

            //             if (showDate != null) {
            //               setState(() {
            //                 dateconfirmController.text =
            //                     DateFormat('yyyy-MM-dd').format(showDate);
            //               });
            //             }
            //           },
            //           decoration: const InputDecoration(labelText: 'CHECK_IN'),
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
