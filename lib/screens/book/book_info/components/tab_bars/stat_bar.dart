import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';

import '../../../../../components/widgets/cards/quote_card.dart';
import '../../../../../components/widgets/cards/review_card.dart';
import '../../../../../models/book_quote.dart';
import '../../../../../models/book_review.dart';

class BookStatisticsTabBar extends StatefulWidget {
  const BookStatisticsTabBar({Key? key}) : super(key: key);

  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<BookStatisticsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late Future<BookReviewList> _futureReviewList;
  late Future<BookQuotesList> _futureQuoteList;

  Future<BookReviewList> getReviewList() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.http(url, '/interactions/reviews/${1}', {'take': '10'}));
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

  Future<BookQuotesList> getQuoteList() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.http(url, '/interactions/quotes/${1}', {'take': '10'}));
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
    _futureReviewList = getReviewList();
    _futureQuoteList = getQuoteList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookReviewList>(
        future: _futureReviewList,
        builder:
            (BuildContext context, AsyncSnapshot<BookReviewList> reviewSnapshot) {
          if (reviewSnapshot.hasData) {
            return FutureBuilder<BookQuotesList>(
                future: _futureQuoteList,
                builder: (BuildContext context,
                    AsyncSnapshot<BookQuotesList> quoteSnapshot) {
                  if (quoteSnapshot.hasData) {
                    return Flexible(
                        child: buildInteractionsTabBar(
                            context, reviewSnapshot.data!, quoteSnapshot.data!));
                  } else if (quoteSnapshot.hasError) {
                    return WebErrorWidget(
                        errorMessage: quoteSnapshot.error.toString());
                  } else {
                    // By default, show a loading spinner.
                    return const LoadingWidget();
                  }
                });
          } else if (reviewSnapshot.hasError) {
            return WebErrorWidget(errorMessage: reviewSnapshot.error.toString());
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }

  Widget buildInteractionsTabBar(BuildContext context,
      BookReviewList reviewList, BookQuotesList quotesList) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.56,
      width: size.width,
      //padding: const EdgeInsets.symmetric(vertical: 13),
      child: Column(
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
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
              unselectedLabelStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              tabs: [
                Tab(text: 'Рецензии  ' + reviewList.count.toString()),
                Tab(text: 'Цитаты  ' + quotesList.count.toString())
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
