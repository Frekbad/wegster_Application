// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:wegster_application/exports/exports.dart';

class SearchContainer extends StatelessWidget {
  final int Hotel_ID;
  final String Hotel_Token;
  final String Hotel_Email;
  final String Hotel_Name;
  final String Hotel_Location;
  final String Hotel_Image;
  final String Hotel_Price;
  final String Hotel_Description;

  const SearchContainer({
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
    final style = TextStyle(
        fontSize: 22, color: Colors.grey[900], fontWeight: FontWeight.bold);

    final style2 = TextStyle(
        fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w600);

    final style3 = TextStyle(
      fontSize: 14,
      color: Colors.grey[800],
    );

    final style4 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey[600],
    );
    return Column(
      children: [
        Container(
          height: 220,
          width: 500,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 4,
                offset: const Offset(6, 0), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            image: DecorationImage(
                image: NetworkImage(Hotel_Image), fit: BoxFit.fill),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: 30,
          ),
          height: 85,
          width: 400,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(5, 0), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(Hotel_Image),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      Hotel_Name,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      Hotel_Location,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: DMColors.blackColor),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 180),
                          // child: Text(
                          //   "Rs ${Hotel_Price}",
                          //   style: const TextStyle(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //       color: DMColors.logoColor),
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
