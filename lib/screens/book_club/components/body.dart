import 'package:flutter/material.dart';
import '../../../models/genre.dart';
import 'top_10_review.dart';
import '../../../models/book.dart';
import '../../../models/user_review.dart';
import 'top_divider.dart';
import 'top_10_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(
            // todo change height to 15
            top: 40,
            bottom: size.height * 0.11),
        height: size.height * 0.9,
        width: size.width,
        child: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: [
              const TopDivider(
                index: 1,
              ),
          Top10BookCard(
                press: () {  },
                book: Book(
                    5000,
                    "Алиса в Стране Чудес",
                    ["Льюис Кэролл"],
                    "https://ie.wampi.ru/2023/11/01/image149212773b50d0e3.png",
                    GenresList([]),
                    0.0,
                    null,
                    "None"
                ),),
              const TopDivider(
                index: 2,
              ),
            ],
          ),
        ));
  }
}
