import 'package:flutter/material.dart';
import '../constants.dart';

class InputTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const InputTextField({Key? key, required this.onChanged}) : super(key: key);

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  var maxLength = 10;
  var textLength = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width * 0.8,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: grayColor)),
      child: TextField(
        onChanged: widget.onChanged,
        keyboardType: TextInputType.multiline,
        maxLength: 1500,
        maxLines: null,
        style: const TextStyle(fontSize: 15),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
