import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class BookDesc extends StatefulWidget {
  const BookDesc({Key? key}) : super(key: key);

  @override
  _BookDescState createState() => _BookDescState();
}

class _BookDescState extends State<BookDesc> {
  bool descTextShowFlag = false;
  String descText =
      'Воистину «рукописи не горят». Произведения Михаила Булгакова не печатали долгое время, но с момента снятия запрета, они стали бестселлерами! Их покупают, читают и перечитывают, цитируют повсеместно, экранизируют, делают театральные постановки, а главное - они по-прежнему актуальны! Потому что, как говорил Воланд: «Люди, как люди. Любят деньги, но ведь это всегда было... Человечество любит деньги, из чего бы те ни были сделаны, из кожи ли, из бумаги ли, из бронзы или золота. Ну, легкомысленны ну, что...';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: descTextShowFlag ? size.height * 0.5 : size.height * 0.25,
      width: size.width,
      //padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Описание',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(descText,
              textAlign: TextAlign.justify,
              maxLines: descTextShowFlag ? 12 : 6),
          InkWell(
            onTap: () {
              setState(() {
                descTextShowFlag = !descTextShowFlag;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(descTextShowFlag ? "Свернуть" : "Развернуть",
                    style: const TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
