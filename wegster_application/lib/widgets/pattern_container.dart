import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PatternContainer extends StatelessWidget {
  final double height;
  final double width;
  final TextInputType keyboardType;
  const PatternContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onSaved: (pin) {},
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        keyboardType: keyboardType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
        )),
      ),
    );
  }
}
