import 'package:flutter/material.dart';
import '../../../../../components/constants.dart';

class TopDivider extends StatelessWidget {
  final int index;

  const TopDivider({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 30,
          width: size.width * 0.35,
          child: const Divider(
            color: secondaryColor,
            thickness: 3,
          ),
        ),
        Container(
          height: size.width * 0.15,
          width: size.width * 0.15,
          decoration: BoxDecoration(
            border: Border.all(
              color: secondaryColor,
              width: 3,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              index.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontSize: size.width * 0.055,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          width: size.width * 0.35,
          child: const Divider(
            color: secondaryColor,
            thickness: 3,
          ),
        ),
      ],
    );
  }
}
