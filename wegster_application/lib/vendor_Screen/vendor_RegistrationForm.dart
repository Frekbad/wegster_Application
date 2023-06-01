// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_declarations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wegster_application/models/user_cubit.dart';
import 'package:wegster_application/models/user_model.dart';
import 'package:wegster_application/validator/validator.dart';
import 'package:wegster_application/vendor_Screen/vendor_Login.dart';
import 'package:wegster_application/widgets/constants.dart';
import 'package:http/http.dart' as http;

import '../exports/exports.dart';

class VendorRegistration extends StatefulWidget {
  const VendorRegistration({super.key});

  @override
  State<VendorRegistration> createState() => _VendorRegistrationState();
}

class _VendorRegistrationState extends State<VendorRegistration> {
  late TextEditingController usernameController;
  late TextEditingController useremailController;

  late TextEditingController useraddressController;

  late TextEditingController passwordconfirmController;
  late TextEditingController userpanController;

  final _logInKey = GlobalKey<FormState>();
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    useremailController = TextEditingController();
    userpanController = TextEditingController();

    useraddressController = TextEditingController();

    passwordconfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    useremailController.dispose();
    userpanController.dispose();

    useraddressController.dispose();

    passwordconfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = context.read<CubitUser>().state;
    // int pk = user.id!;

    Future<void> postHotels(String businessName, String email, String address,
        String token, String description, File? image, int id) async {
      final url = ("$baseUrl/user/Hotel/");

      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Add image file to the request
      if (image != null) {
        final imageField = await http.MultipartFile.fromPath(
          'Hotel_Image',
          image.path,
        );
        request.files.add(imageField);
      }

      // Add other fields to the request
      request.fields['HotelName'] = businessName;
      request.fields['Hotel_Location'] = address;

      request.fields['Hotel_Description'] = description;
      request.fields['Hotel_email'] = email;
      request.fields['Hotel_Token'] = token;
      request.fields['Hotel_ID'] = id.toString();

      final res = await request.send();

      if (res.statusCode == 200 || res.statusCode == 201) {
        Fluttertoast.showToast(
            msg: 'Hotel Details has been Successfully Posted',
            fontSize: 18,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: DMColors.lightGreenColor,
            textColor: DMColors.loginColor);
      } else {
        // Failed to post data
        Fluttertoast.showToast(
            msg: 'Sorry! Hotel data has already been posted',
            fontSize: 18,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: DMColors.redColor,
            textColor: DMColors.loginColor);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DMColors.backgroundwhiteColor,
      appBar: AppBar(
        backgroundColor: DMColors.backgroundwhiteColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _logInKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                color: Colors.blue), //apply style to all
                            children: [
                          TextSpan(
                            text: 'Fill Up Form ... ',
                            style: TextStyle(
                              color: DMColors.googleColor2,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'ProximaNova',
                              decoration: TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                              text: 'Now!',
                              style: TextStyle(
                                color: DMColors.logoColor,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ProximaNova',
                                decoration: TextDecoration.none,
                              )),
                        ])),
                  ),
                  const SizedBox(height: 35),
                  SignUpContainer(
                    controller: usernameController,
                    name: 'Hotel Name',
                    prefix: const Icon(
                      Icons.house_siding_outlined,
                      color: DMColors.logoColor,
                    ),
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Enter your name';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    obsecure: false,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SignUpContainer(
                    controller: useremailController,
                    name: 'Hotel Email',
                    prefix: const Icon(
                      Icons.email_rounded,
                      color: DMColors.orangeColor,
                    ),
                    validator: FieldValidate.validateEmail,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SignUpContainer(
                    controller: useraddressController,
                    name: 'Hotel Location',
                    prefix: const Icon(
                      Icons.location_on_outlined,
                      color: DMColors.redColor,
                    ),
                    validator: (address) {
                      if (address!.isEmpty) {
                        return 'Enter your address';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    obsecure: false,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SignUpContainer(
                    controller: userpanController,
                    name: 'Hotel Pan',
                    prefix: const Icon(
                      Icons.location_on_outlined,
                      color: DMColors.redColor,
                    ),
                    validator: (pan) {
                      if (pan!.isEmpty) {
                        return 'Enter your pan ';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    obsecure: false,
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  SignUpContainer(
                    controller: passwordconfirmController,
                    name: 'Hotel Description',
                    obsecure: false,
                    fill: true,
                    needarea: true,
                    prefix: const Icon(
                      Icons.description,
                      color: DMColors.pinkredColor,
                    ),
                    validator: FieldValidate.validatePassword,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            // Replace Colors.blue with the desired background color
                            border: Border.all(
                              color: DMColors
                                  .backgroundColor, // Replace Colors.black with the desired border color
                              width:
                                  2.0, // Replace 2.0 with the desired border width
                            ),
                          ),
                          child: Center(
                              child: image != null
                                  ? Image.file(
                                      image!,
                                      width: 160,
                                      height: 160,
                                    )
                                  : const Text("Your Image"))),
                      Center(
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: Container(
                            width: 140,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: DMColors.lightGreenColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.image_outlined,
                                  color: DMColors.backgroundwhiteColor,
                                ),
                                Text(
                                  "Pick your Image",
                                  style: TextStyle(
                                      color: DMColors.backgroundwhiteColor),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  InkWell(
                    onTap: () {
                      final isValidForm = _logInKey.currentState!.validate();
                      if (isValidForm) {
                        postHotels(
                            usernameController.text,
                            useremailController.text,
                            useraddressController.text,
                            userpanController.text,
                            passwordconfirmController.text,
                            image,
                            user.id!);
                        setState(() {
                          usernameController.clear();
                          useremailController.clear();
                          useraddressController.clear();
                          userpanController.clear();
                          passwordconfirmController.clear();
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.98),
                          boxShadow: [
                            BoxShadow(
                              color: DMColors.orangeColor.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(
                                  3, 4), // changes position of shadow
                            ),
                          ],
                          color: DMColors.logoColor),
                      alignment: Alignment.center,
                      child: const LabelText(
                          name: 'Submit',
                          color: DMColors.loginColor,
                          size: 17,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LabelText(
                          name: "Already Submitted Form ?",
                          color: DMColors.textColor,
                          size: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'ProximaNova',
                          textDecoration: TextDecoration.none),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const VendorLogin(),
                          ));
                          //GoRouter.of(context).go('/');
                        },
                        child: const LabelText(
                            name: "Login",
                            color: DMColors.borderColor,
                            size: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'ProximaNova',
                            textDecoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
