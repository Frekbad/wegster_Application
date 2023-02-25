import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key, required this.name, required this.color, required this.image})
      : super(key: key);

  final String name;

  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            SvgPicture.asset(image),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
