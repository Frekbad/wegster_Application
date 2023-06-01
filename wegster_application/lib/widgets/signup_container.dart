// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../exports/exports.dart';

class SignUpContainer extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final FormFieldValidator<String> validator;
  final bool obsecure;
  final TextInputType keyboardType;
  final Widget? suffix;
  final Widget? prefix;
  final bool? fill;

  final bool needarea;

  const SignUpContainer({
    Key? key,
    required this.controller,
    required this.name,
    required this.validator,
    this.obsecure = false,
    required this.keyboardType,
    this.suffix,
    this.prefix,
    this.fill,
    this.needarea = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
          maxLines: needarea ? 5 : 1,
          obscureText: obsecure,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            labelText: name,
            prefixIcon: prefix,
            suffixIcon: suffix,
            hintText: name,
            hintStyle: const TextStyle(color: DMColors.textColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: DMColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: DMColors.greenColor),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: DMColors.greywhiteColor),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: DMColors.greenColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: validator),
    );
  }
}
