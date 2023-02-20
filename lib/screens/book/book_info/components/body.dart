import 'package:flutter/material.dart';

import 'book_main_info.dart';
import 'stat_row.dart';
import 'status_tab_bar.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(
            left: 15, right: 15, top: 15, bottom: size.height * 0.1),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            BookMainInfo(),
            StatisticRow(),
            StatusTabBar(),

          ],
        ));
  }
}
