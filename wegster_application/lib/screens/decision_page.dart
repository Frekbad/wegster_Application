import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wegster_application/themes/dm_color_theme.dart';
import 'package:wegster_application/widgets/text_field_container.dart';
import 'package:wegster_application/widgets/text_widget.dart';

void main() {
  runApp(const Decision());
}

class Decision extends StatelessWidget {
  const Decision({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/homePage');
                  },
                  child: const Icon(Icons.arrow_back_rounded)),
              const SizedBox(
                height: 17,
              ),
              const LabelText(
                  name: 'What do you want to decide on?',
                  color: DMColors.textColor,
                  size: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ProximaNova',
                  textDecoration: TextDecoration.none),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: TextContainer(
                    color: DMColors.transparentColor, fill: true, line: 1),
              ),
              const SizedBox(
                height: 30,
              ),
              const LabelText(
                  name: 'what is the objective of your decision?',
                  color: DMColors.textColor,
                  size: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ProximaNova',
                  textDecoration: TextDecoration.none),
              const SizedBox(height: 5),
              const TextContainer(
                  color: DMColors.transparentColor, fill: true, line: 12),
              const SizedBox(
                height: 230,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: DMColors.borderColor,
                  ),
                  child: SvgPicture.asset(
                    "assets/image/arrow.svg",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
