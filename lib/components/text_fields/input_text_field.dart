import 'package:flutter/material.dart';
import '../constants.dart';

class InputTextField extends StatefulWidget {
  final double height;
  final int maxLen;
  final ValueChanged<String> onChanged;

  const InputTextField(
      {Key? key,
      required this.onChanged,
      required this.height,
      required this.maxLen})
      : super(key: key);

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width * 0.8,
      height: size.height * widget.height,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: grayColor)),
      child: TextField(
        onChanged: widget.onChanged,
        keyboardType: TextInputType.multiline,
        maxLength: widget.maxLen == 0 ? TextField.noMaxLength : widget.maxLen,
        maxLines: widget.maxLen == 0 ? 1 : null,
        style: const TextStyle(fontSize: 15),
        cursorColor: primaryColor,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
