import 'package:flutter/material.dart';
import 'tab_bars/stat_bar.dart';

import 'book_desc.dart';
import 'book_main_info.dart';
import 'stat_row.dart';
import 'tab_bars/status_tab_bar.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(
            left: 15, right: 15, top: 15, bottom: size.height * 0.01),
        height: size.height * 1.3,
        width: size.width,
        child: Column(
          children: [
            BookMainInfo(),
            StatisticRow(),
            StatusTabBar(),
            Flexible(
              child: Column(
                children: [
                  BookDesc(),
                  BookStatisticsTabBar()
                ],
              )
            ),
          ],
        ));
  }
}
