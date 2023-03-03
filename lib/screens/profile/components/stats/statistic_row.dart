import 'package:flutter/material.dart';
import 'package:shelfie/models/statistic.dart';

import 'stat_card.dart';

class StatisticRow extends StatelessWidget {
  final Statistic userStat;

  const StatisticRow({Key? key, required this.userStat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List icons = ['book', 'review', 'achieve'];
    List titles = ['Моя библиотека', 'Рецензии', 'Достижения'];
    List stats = [userStat.getBookCount(), userStat.getReviewCount(), userStat.getAchievementCount()];

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
      //width: size.width * 0.32,
      height: size.height * 0.11,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stats.length,
          itemBuilder: (context, index) => StatCard(
            text: titles[index],
            iconName: icons[index],
            press: () {},
            countNum: stats[index],
          ),
      ),
    );
  }
}