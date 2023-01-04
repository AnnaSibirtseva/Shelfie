import 'package:flutter/material.dart';

import '../constants.dart';
import 'button_state.dart';

class FilterButton extends StatelessWidget {
  final bool pressed;

  const FilterButton({
    Key? key,
    required this.pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 20, top: 30),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: pressed ? primaryColor : whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primaryColor)),
        child: SizedBox(
          height: 20,
          width: 20,
          child: pressed
              ? Image.asset('assets/icons/white_filter.png')
              : Image.asset('assets/icons/blue_filter.png'),
        ),
      ),
      onTap: () {

      },
    );
  }
}