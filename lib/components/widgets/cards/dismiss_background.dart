import 'package:flutter/material.dart';

import '../../constants.dart';

class DismissBackground extends StatelessWidget {
  final double verticalMargin;

  const DismissBackground({Key? key, required this.verticalMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
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
