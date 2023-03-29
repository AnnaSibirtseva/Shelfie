import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width * 0.75,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor)),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 19),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: grayColor,
          ),
          hintStyle: const TextStyle(color: grayColor, fontSize: 20),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
