import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/models/statistic.dart';

class StatisticRow extends StatelessWidget {
  final Statistic userStat;

  const StatisticRow({Key? key, required this.userStat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
      //width: size.width * 0.32,
      //height: size.height * 0.1,
      child:  Row(
        children: <Widget>[
          buildStatListItem(
              size, 'book', 420, 'Моя библиотека'),

        ],
      ),
    );
  }

  Widget buildStatListItem(Size size, String icon, int num, String text) {
    return Flexible(
          child: Container(
            //margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                      child: Text(num.toString(),
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
                      child: Image.asset('assets/images/$icon.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }

// Widget buildStatListItem(Size size, String icon, int num) {
//   return Container(
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: secondaryColor),
//     child: Row(
//       children: [
//         SizedBox(
//           height: size.height * 0.12,
//           width: size.width * 0.12,
//           child: Image.asset('assets/images/$icon.png'),
//         ),
//         Text(
//           num.toString(),
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               fontFamily: 'VelaSansExtraBold',
//               //color: Colors.black,
//               fontSize: size.width / 13,
//               fontWeight: FontWeight.w800),
//         ),
//       ],
//     ),
//   );
// }

}
