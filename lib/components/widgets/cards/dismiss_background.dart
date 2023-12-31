import 'package:flutter/material.dart';

import '../../constants.dart';

class DismissBackground extends StatelessWidget {
  const DismissBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: redColor, borderRadius: BorderRadius.all(Radius.circular(15))),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(
        Icons.delete,
        color: whiteColor,
      ),
    );
  }
}
