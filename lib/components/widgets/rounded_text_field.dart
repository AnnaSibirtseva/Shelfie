import 'package:flutter/material.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.indigo.shade600)),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 19),
        cursorColor: Colors.indigo.shade600,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.black38,
          ),
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 20),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
