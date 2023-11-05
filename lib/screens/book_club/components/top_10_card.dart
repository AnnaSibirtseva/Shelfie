import 'package:flutter/material.dart';
import 'package:shelfie/models/user_review.dart';
import 'top_10_main_info.dart';
import 'package:shelfie/screens/book_club/components/top_10_review.dart';

import '../../../models/book.dart';
import '../../../../components/constants.dart';

class Top10BookCard extends StatelessWidget {
  final VoidCallback press;
  final Book book;

  const Top10BookCard({
    Key? key,
    required this.press,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.05),
        padding: const EdgeInsets.all(5),
        //height: size.height * 0.7,
        width: size.width * 0.9,
        child:
        Column(
          children: [
            Top10MainInfo(book: book),
            const SizedBox(height: 15),
          SingleChildScrollView(
            reverse: false,
            child:
            Top10ReviewCard(
                review: UserReview(
                    15,
                    5000,
                    "Алиса в Стране Чудес",
                    "https://ie.wampi.ru/2023/11/01/image149212773b50d0e3.png",
                    ["Льюис Кэролл"],
                    "Само произведение отлично, но, правда, не для детей. а для подростков. Проверено на себе-в детстве она мне крайне не понравилась. А теперь об данном издании сего шедевра-на мой взгляд оно так себе. Такое ощущение у меня возникло, когда я читала Гарри Поттера от Махаона. Многие имена переиначены, и на слух отвратительны. Яркие тому представители-Двойюнушечка и Двойняшечка, которыми оказываются братишки Труляля и Траляля. а Пустик-Дутик. которым оказывается всеми известный Шалтай-Болтай. Ужас в общем. Суть произведения не поменялась, но от данных подковырок периодически мутит. Хороший плюс издания-стоимость и размер(книжка небольшая). В общем, оценка к произведению у меня 10 из 10, оценка к оформлению-7 из 10(странички газетные), а оценка переводу 5 из 10",
                    "Заголовок отзыва",
                    7.0)))
          ],
        )
      ),
    );
  }
}
