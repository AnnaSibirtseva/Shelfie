import 'package:flutter/material.dart';
import 'package:shelfie/models/top-10_book.dart';
import 'top_divider.dart';
import 'top_10_main_info.dart';
import 'top_10_review.dart';

class Top10BookCard extends StatelessWidget {
  final VoidCallback press;
  final Top10BookInfo book;

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
          child: Column(
            children: [
              Top10MainInfo(book: book),
              const SizedBox(height: 15),
              if (book.getReview() != null)
                SingleChildScrollView(
                    reverse: false,
                    child: Top10ReviewCard(review: book.getReview()!))
            ],
          )),
    );
  }
}

class Top10ListCard extends StatelessWidget {
  final Top10BookInfo book;
  final VoidCallback press;
  final int index;

  const Top10ListCard(
      {Key? key, required this.press, required this.book, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TopDivider(
        index: index,
      ),
      Top10BookCard(press: press, book: book)
    ]);
  }
}
