import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleContainer extends StatelessWidget {
  final String image;
  final Color color;
  final double height;
  final double widht;

  const CircleContainer(
      {Key? key,
      required this.image,
      required this.color,
      required this.height,
      required this.widht})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: widht,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(image, height: 20, width: 20),
      ),
    );
  }
}
