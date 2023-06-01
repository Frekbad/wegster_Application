import 'package:flutter/material.dart';

import '../exports/exports.dart';

class TextContainer extends StatelessWidget {
  final Color color;
  final bool fill;
  final int line;
  const TextContainer(
      {Key? key, required this.color, required this.fill, required this.line})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: fill,
          fillColor: DMColors.loginColor,
        ),
        maxLines: line,
      ),
    );
  }
}
