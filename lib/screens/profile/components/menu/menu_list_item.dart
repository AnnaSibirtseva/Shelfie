import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../components/constants.dart';

class MenuListItem extends StatelessWidget {
  final VoidCallback press;
  final String text;

  const MenuListItem({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Row(
          children: [
            Text(text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w400)),
            const Spacer(),
            Transform.rotate(
              angle: 180 * math.pi / 180,
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 18,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
