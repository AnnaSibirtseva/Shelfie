import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../components/constants.dart';
import '../../../../components/widgets/error.dart';
import '../../../../components/widgets/loading.dart';

import '../../../../models/book.dart';
import '../../../../models/book_quote.dart';
import '../../../../models/book_review.dart';
import '../../../../models/inherited_id.dart';
import 'book_desc.dart';
import 'book_main_info.dart';
import 'stat_row.dart';
import 'tab_bars/stat_bar.dart';

class Body extends StatelessWidget {
  final Book book;

  const Body({Key? key, required this.book}) : super(key: key);

  Future<BookReviewList> getReviewList(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(
              url, '/interactions/reviews/${book.getId()}', {'take': '10'}),
          headers: {'userId': id.toString()});
      if (response.statusCode == 200) {
        return BookReviewList.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<BookQuotesList> getQuoteList(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/interactions/quotes/${book.getId()}', {'take': '10'}),
          headers: {'userId': id.toString()});
      if (response.statusCode == 200) {
        return BookQuotesList.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    Size size = MediaQuery.of(context).size;
    late BookReviewList reviewList;
    late BookQuotesList quoteList;

    return FutureBuilder<BookReviewList>(
        future: getReviewList(inheritedWidget.id),
        builder: (BuildContext context,
            AsyncSnapshot<BookReviewList> reviewSnapshot) {
          if (reviewSnapshot.hasData) {
            reviewList = reviewSnapshot.data!;
            return FutureBuilder<BookQuotesList>(
                future: getQuoteList(inheritedWidget.id),
                builder: (BuildContext context,
                    AsyncSnapshot<BookQuotesList> quoteSnapshot) {
                  if (quoteSnapshot.hasData) {
                    quoteList = quoteSnapshot.data!;
                    return buildPageUI(size, reviewList, quoteList);
                  } else {
                    return const SmallLoadingWidget();
                  }
                });
          } else if (reviewSnapshot.hasError) {
            return WebErrorWidget(
                errorMessage: reviewSnapshot.error.toString());
          } else {
            return const SmallLoadingWidget();
          }
        });
  }

  Widget buildPageUI(
      Size size, BookReviewList reviewList, BookQuotesList quoteList) {
    return Container(
        margin: EdgeInsets.only(
            left: 15, right: 15, top: 15, bottom: size.height * 0.01),
        height: size.height * 1.5,
        width: size.width,
        child: Column(
          children: [
            BookMainInfo(book: book),
            Flexible(
                child: Column(
              children: [
                StatisticRow(
                  book: book,
                  quoCount: quoteList.count,
                  revCount: reviewList.count,
                ),
                // StatusTabBar(book: book),
                BookDesc(desc: book.getDesc() == null ? '-' : book.getDesc()!),
                BookStatisticsTabBar(
                  reviewList: reviewList,
                  quoteList: quoteList,
                  book: book,
                )
              ],
            )),
          ],
        ));
  }
}
