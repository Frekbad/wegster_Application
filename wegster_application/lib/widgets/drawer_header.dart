import 'package:flutter/material.dart';
import 'package:wegster_application/widgets/text_widget.dart';

import '../exports/exports.dart';

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: DMColors.greywhiteColor,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            LabelText(
                name: 'John Doe',
                color: DMColors.textColor,
                size: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'ProximaNova',
                textDecoration: TextDecoration.none),
            SizedBox(
              height: 2,
            ),
            LabelText(
                name: 'johndoe@gmail.com',
                color: DMColors.textColor,
                size: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'ProximaNova',
                textDecoration: TextDecoration.none),
          ],
        ),
        const SizedBox(
          width: 43,
        ),
        const Icon(Icons.menu),
      ],
    );
  }
}
