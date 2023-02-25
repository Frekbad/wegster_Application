import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String name;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextDecoration textDecoration;
  const LabelText({
    Key? key,
    required this.name,
    required this.color,
    required this.size,
    required this.fontWeight,
    required this.fontFamily,
    required this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          decoration: textDecoration),
    );
  }
}
