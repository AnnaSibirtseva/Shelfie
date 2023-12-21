import 'package:flutter/material.dart';

import '../constants.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final bool reverse;
  final VoidCallback press;
  final bool isAsync;

  const DialogButton({
    Key? key,
    required this.text,
    required this.press,
    required this.reverse,
    required this.isAsync,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Flexible(
        child: Container(
            width: size.width * 0.3,
            child: newElevatedButton(context)));
  }

  Widget newElevatedButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: reverse ? whiteColor : primaryColor,
          side: BorderSide(width: reverse ? 1 : 0, color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 10)),
      onPressed: isAsync ? press : () => press,
      child: Text(
        text,
        style: TextStyle(
            fontSize: size.width / 30,
            fontWeight: FontWeight.w700,
            color: reverse ? primaryColor : whiteColor),
      ),
    );
  }
}
