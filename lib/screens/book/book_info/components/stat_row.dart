import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class StatisticRow extends StatelessWidget {
  const StatisticRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List titles = ['Среднее время чтения', 'Прочитали', 'Рецензий', 'Цитат'];
    List stats = ['20 дней', 4302, 647, 1755];

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
      //width: size.width * 0.32,
      height: size.height * 0.085,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stats.length,
          itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: secondaryColor),
                child: Column(
                  crossAxisAlignment: index == 0
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (index == 0)
                          SizedBox(
                            height: 20,
                            child: Image.asset('assets/images/clock.png'),
                          ),
                        SizedBox(width: index == 0 ? 5 : 0),
                        Flexible(
                          child: Text(stats[index].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontFamily: 'VelaSansExtraBold',
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
    );
  }
}
