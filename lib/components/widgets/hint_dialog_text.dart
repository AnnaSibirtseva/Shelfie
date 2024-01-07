import 'package:flutter/material.dart';
import '../constants.dart';

class HintDialogText extends StatelessWidget {
  final String text;

  const HintDialogText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 20),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontStyle: FontStyle.italic,
            color: grayColor,
            fontSize: size.width / 30,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
