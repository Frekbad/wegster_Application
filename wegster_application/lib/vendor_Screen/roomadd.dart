// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_final_fields, non_constant_identifier_names, prefer_const_constructors, unused_label
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:wegster_application/api/auth/django_authentication_api.dart';
import 'package:wegster_application/exports/exports.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/validator/validator.dart';

import '../models/user_model.dart';

class VendorAddDeals extends StatefulWidget {
  final int HotelID;
  const VendorAddDeals({
    Key? key,
    required this.HotelID,
  }) : super(key: key);

  @override
  State<VendorAddDeals> createState() => _VendorAddDealsState();
}

class _VendorAddDealsState extends State<VendorAddDeals> {
  bool _obscureText = true;
  bool _obscureTextroom = true;
  bool _obscureTextprice = true;
  bool _obscureTextrefund = true;
  TextEditingController _Bed_Type = TextEditingController();
  TextEditingController _Room_Type = TextEditingController();

  TextEditingController _price_per_night = TextEditingController();
  TextEditingController _refundable_Option = TextEditingController();

  // void _Show() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //     _obscureTextroom = !_obscureTextroom;
  //     _obscureTextprice = !_obscureTextprice;
  //     _obscureTextrefund = !_obscureTextrefund;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    User user = context.read<CubitUser>().state;

    int pk = user.id!;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: DMColors.backgroundColor,
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: DMColors.logoColor,
          title: Text(
            'Add Your Rooms',
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'ProximaNova',
                fontWeight: FontWeight.w900,
                color: DMColors.backgroundwhiteColor),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/image/rooms.jpg'),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: DMColors.backgroundwhiteColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: DMColors.logoColor.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(
                                1.5, 2), // changes position of shadow
                          ),
                        ],
                        //color: Colors.white,
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
                              controller: _Bed_Type,
                              validator: FieldValidate.valueToken,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter Bed Type',
                                icon: Icon(
                                  Icons.bed_outlined,
                                  color: DMColors.blackColor,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off_rounded,
                                    )),

                                //alignLabelWithHint: true,
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: DMColors.blackColor,
                                    fontWeight: FontWeight.w600),
                              )))),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: DMColors.backgroundwhiteColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: DMColors.logoColor.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(
                                1.5, 2), // changes position of shadow
                          ),
                        ],
                        //color: Colors.white,
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
                              controller: _Room_Type,
                              validator: FieldValidate.valueToken,
                              obscureText: _obscureTextroom,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter Room Type',
                                icon: Icon(
                                  Icons.roofing_sharp,
                                  color: DMColors.marronColor,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureTextroom = !_obscureTextroom;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureTextroom
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off_rounded,
                                    )),

                                //alignLabelWithHint: true,
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: DMColors.blackColor,
                                    fontWeight: FontWeight.w600),
                              )))),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: DMColors.backgroundwhiteColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: DMColors.logoColor.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(
                                1.5, 2), // changes position of shadow
                          ),
                        ],
                        //color: Colors.white,
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
                              controller: _price_per_night,
                              validator: FieldValidate.valueToken,
                              obscureText: _obscureTextprice,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter Price',
                                icon: Icon(
                                  Icons.attach_money_rounded,
                                  color: DMColors.greenColor,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureTextprice = !_obscureTextprice;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureTextprice
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off_rounded,
                                    )),

                                //alignLabelWithHint: true,
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: DMColors.blackColor,
                                    fontWeight: FontWeight.w600),
                              )))),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: DMColors.backgroundwhiteColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: DMColors.logoColor.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(
                                1.5, 2), // changes position of shadow
                          ),
                        ],
                        //color: Colors.white,
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
                              controller: _refundable_Option,
                              validator: FieldValidate.valueToken,
                              obscureText: _obscureTextrefund,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter Refundable Option',
                                icon: Icon(
                                  Icons.replay_circle_filled_rounded,
                                  color: DMColors.blackColor,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureTextrefund =
                                            !_obscureTextrefund;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureTextrefund
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off_rounded,
                                    )),

                                //alignLabelWithHint: true,
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: DMColors.blackColor,
                                    fontWeight: FontWeight.w600),
                              )))),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: GestureDetector(
                    onTap: () {
                      if (_Bed_Type.text.isNotEmpty &&
                          _Room_Type.text.isNotEmpty &&
                          _price_per_night.text.isNotEmpty &&
                          _refundable_Option.text.isNotEmpty) {
                        String id = widget.HotelID.toString();
                        postRoomDetails(_Bed_Type.text, _Room_Type.text,
                            _price_per_night.text, _refundable_Option.text, id);
                        setState(() {
                          _Bed_Type.clear();
                          _Room_Type.clear();
                          _price_per_night.clear();
                          _refundable_Option.clear();
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Room Success'),
                            content: const Text(
                              "Room has been successfully added in Wegster system.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Room Post failed'),
                            content: const Text(
                              "Please provide Rooms data in all fields before posting the rooms.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: DMColors.logoColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Post',
                          style: TextStyle(
                              color: DMColors.backgroundwhiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
