import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class StatCard extends StatelessWidget {
  final VoidCallback press;
  final String text;
  final int countNum;
  final String iconName;

  const StatCard({
    Key? key,
    required this.press,
    required this.text,
    required this.countNum,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: press,
        child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: secondaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(countNum.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: size.width * 0.075,
                              fontFamily: 'VelaSansExtraBold',
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      height: size.height * 0.04,
                      child: Image.asset('assets/images/$iconName.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
