import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/cards/quote_card.dart';
import 'package:shelfie/models/book_quote.dart';

import '../../../../../components/widgets/cards/review_card.dart';
import '../../../../../models/book.dart';
import '../../../../../models/book_review.dart';

/*
когда появится кнопка показать больше, просто будут заново инициализироваться
 */
class BookStatisticsTabBar extends StatefulWidget {
  final Book book;
  final BookReviewList reviewList;
  final BookQuotesList quoteList;

  const BookStatisticsTabBar(
      {Key? key,
      required this.book,
      required this.reviewList,
      required this.quoteList})
      : super(key: key);

  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<BookStatisticsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BookReviewList _reviewList;
  late BookQuotesList _quoteList;

  Future<BookReviewList> getReviewList(int id, take, skip) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/interactions/reviews/${widget.book.getId()}',
              {'take': take.toString(), 'skip': skip.toString()}),
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

  Future<BookQuotesList> getQuoteList(int id, take, skip) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/interactions/quotes/${widget.book.getId()}',
              {'take': take.toString(), 'skip': skip.toString()}),
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
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
    _reviewList = widget.reviewList;
    _quoteList = widget.quoteList;
  }

  @override
  Widget build(BuildContext context) {
    return buildInteractionsTabBar(context, _reviewList, _quoteList);
  }

  Widget buildInteractionsTabBar(BuildContext context,
      BookReviewList reviewList, BookQuotesList quotesList) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: size.width * 0.80,
                  child: TabBar(
                    //isScrollable: true,
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: primaryColor,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                    tabs: [
                      Tab(text: 'Рецензии  ' + reviewList.count.toString()),
                      Tab(text: 'Цитаты  ' + quotesList.count.toString())
                    ],
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.library_add_rounded , color: primaryColor),
                    onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                SingleChildScrollView(
                  reverse: false,
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Добавить рецензию', style: TextStyle(color: grayColor)),
                          style: ElevatedButton.styleFrom(
                            primary: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      for (BookReview review in reviewList.reviews)
                        ReviewCard(review: review)
                    ],
                  ),
                ),

                // second tab bar view widget
                SingleChildScrollView(
                  reverse: false,
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Добавить цитату', style: TextStyle(color: grayColor)),
                          style: ElevatedButton.styleFrom(
                            primary: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      for (BookQuote quote in quotesList.quotes)
                        QuoteCard(quote: quote)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
