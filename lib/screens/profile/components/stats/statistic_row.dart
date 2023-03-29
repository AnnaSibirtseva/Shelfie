import 'package:flutter/material.dart';
import 'package:shelfie/models/statistic.dart';

import 'stat_card.dart';

class StatisticRow extends StatelessWidget {
  final Statistic userStat;
  final List routes;

  const StatisticRow({Key? key, required this.userStat, required this.routes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List icons = ['book', 'review', 'quote'];
    List titles = ['Моя библиотека', 'Рецензии', 'Цитаты'];
    List stats = [
      userStat.getBookCount(),
      userStat.getReviewCount(),
      userStat.getQuoteCount()
    ];

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
      height: size.height * 0.11,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        itemBuilder: (context, index) => StatCard(
          text: titles[index],
          iconName: icons[index],
          press: routes[index],
          countNum: stats[index],
        ),
      ),
    );
  }
}
