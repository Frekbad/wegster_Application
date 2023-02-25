import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../exports/exports.dart';

class SocialLoginButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onClick;
  const SocialLoginButton({
    Key? key,
    required this.image,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: DMColors.googleColor,
            border: Border.all(
                //color: DMColors.textColor,
                ),
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              SvgPicture.asset(
                image,
              ),
              const SizedBox(
                width: 50,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'ProximaNova',
                  fontStyle: FontStyle.normal,
                  color: DMColors.loginColor,
                ),
              ),
            ],
          )),
    );
  }
}
