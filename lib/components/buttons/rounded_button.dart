import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // Indents top and bottom.
        margin: const EdgeInsets.symmetric(vertical: 30),
        child: newElevatedButton(context));
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.indigo.shade600,
          // Moves text in the button.
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
      onPressed: press,
    );
  }
}
