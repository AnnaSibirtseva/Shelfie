import 'package:flutter/material.dart';

import '../constants.dart';

class ButtonState extends State<StatefulWidget> {
  final bool list;
  bool reverse = false;
  String type = 'list';

  ButtonState(this.list);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.2,
        height: size.width * 0.2,
        decoration: BoxDecoration(
            color: reverse ? whiteColor : primaryColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: primaryColor, width: 2)),
        child: SizedBox(
          height: size.height * 0.09,
          width: size.width * 0.09,
          // child: reverse
          //     ? Image.asset('assets/icons/blue_${}.png')
          //     : Image.asset('assets/icons/white_${}.png'),
        ),
      ),
      onTap: () {
        setState(() {
          reverse = !reverse;
        });
      },
    );
  }
}
