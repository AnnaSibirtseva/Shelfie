import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/models/statistic.dart';
import 'package:shelfie/screens/profile/profile_head.dart';
import 'package:shelfie/screens/profile/profile_page.dart';
import 'package:shelfie/screens/profile/statistic_row.dart';

import 'menu.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProfileHead(),
          StatisticRow(userStat: user.getStatistics()),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Text('Общее'.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          const Menu(titles: ['Книги', 'Рецензии', 'Цитаты', 'Сборники', 'Достижения', 'Статистика']),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Text('дополнительно'.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          const Menu(titles: ['Настройки', 'О приложении', 'Выйти']),
        ],
      ),
    );
  }
}
