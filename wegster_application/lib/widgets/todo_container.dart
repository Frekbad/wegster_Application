// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';

import 'package:wegster_application/exports/exports.dart';

class TodoContainer extends StatelessWidget {
  final int Hotel_ID;
  final String Hotel_Token;
  final String Hotel_Email;
  final String Hotel_Name;
  final String Hotel_Location;
  final String Hotel_Image;
  final String Hotel_Price;
  final String Hotel_Description;

  const TodoContainer({
    Key? key,
    required this.Hotel_ID,
    required this.Hotel_Token,
    required this.Hotel_Email,
    required this.Hotel_Name,
    required this.Hotel_Location,
    required this.Hotel_Image,
    required this.Hotel_Price,
    required this.Hotel_Description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        Container(
          height: 300,
          width: 190,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(Hotel_Image),
                    fit: BoxFit.fill,
                    scale: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(Hotel_Name),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                Hotel_Location,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const LabelText(
                        name: 'Rs',
                        color: DMColors.blackColor,
                        size: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ProximaNova',
                        textDecoration: TextDecoration.none),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      Hotel_Price,
                      style: const TextStyle(
                        color: DMColors.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ProximaNova',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
