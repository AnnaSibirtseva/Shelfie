import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../components/constants.dart';
import '../../../../../components/widgets/cards/quote_card.dart';
import '../../../../../components/widgets/cards/review_card.dart';
import '../../../../../components/widgets/dialogs/add_book_dialog.dart';
import '../../../../../components/widgets/dialogs/add_quote_dialog.dart';
import '../../../../../components/widgets/dialogs/add_review_dialog.dart';
import '../../../../../models/book.dart';
import '../../../../../models/book_quote.dart';
import '../../../../../models/book_review.dart';
import '../../../../../models/inherited_id.dart';
import '../../../components/widgets/cards/serch_club_card.dart';
import '../../../models/book_club.dart';
import '../../../models/tag.dart';

class SearchTabBar extends StatefulWidget {
  // final BookReviewList reviewList;
  // final BookQuotesList quoteList;

  const SearchTabBar({
    Key? key,
    // required this.reviewList,
    // required this.quoteList
  }) : super(key: key);

  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<SearchTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // late BookReviewList _reviewList;
  // late BookQuotesList _quoteList;
  late int id;

  // Future<BookReviewList> getReviewList(int id, take, skip) async {
  //   var client = http.Client();
  //   try {
  //     var response = await client.get(
  //         Uri.https(url, '/interactions/reviews/${widget.book.getId()}',
  //             {'take': take.toString(), 'skip': skip.toString()}),
  //         headers: {'userId': id.toString()});
  //     if (response.statusCode == 200) {
  //       return BookReviewList.fromJson(
  //           jsonDecode(utf8.decode(response.bodyBytes)));
  //     } else {
  //       throw Exception();
  //     }
  //   } finally {
  //     client.close();
  //   }
  // }
  //
  // Future<BookQuotesList> getQuoteList(int id, take, skip) async {
  //   var client = http.Client();
  //   try {
  //     var response = await client.get(
  //         Uri.https(url, '/interactions/quotes/${widget.book.getId()}',
  //             {'take': take.toString(), 'skip': skip.toString()}),
  //         headers: {'userId': id.toString()});
  //     if (response.statusCode == 200) {
  //       return BookQuotesList.fromJson(
  //           jsonDecode(utf8.decode(response.bodyBytes)));
  //     } else {
  //       throw Exception();
  //     }
  //   } finally {
  //     client.close();
  //   }
  // }
  //
  // Future<FutureOr> onQuotesGoBack(dynamic value) async {
  //   _quoteList = await getQuoteList(id, 50, 0);
  //   setState(() {});
  // }
  //
  // Future<FutureOr> onReviewsGoBack(dynamic value) async {
  //   _reviewList = await getReviewList(id, 50, 0);
  //   setState(() {});
  // }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
    // _reviewList = widget.reviewList;
    // _quoteList = widget.quoteList;
  }

  @override
  Widget build(BuildContext context) {
    //todo change to lists
    return buildInteractionsTabBar(context);
  }

  Widget buildInteractionsTabBar(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TabBar(
                  // isScrollable: true,
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
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                  tabs: [
                    Tab(text: 'Мои  ' /*reviewList.count.toString()*/),
                    Tab(text: 'Все  ' /*quotesList.count.toString()*/)
                  ],
                )),
              ],
            ),
          ),
          SizedBox(
            width: size.width,
            child: ElevatedButton(
              onPressed: () => {},
              // showDialog(
              // context: context,
              // builder: (BuildContext context) =>
              //     AddReviewDialog(
              //         book: widget.book,
              //         id: inheritedWidget.id)),
              // .then(onReviewsGoBack),
              child: const Text('Добавить клуб',
                  style: TextStyle(color: grayColor)),
              style: ElevatedButton.styleFrom(
                primary: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
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
                      for (int i = 0; i < 6; ++i)
                        SearchBookClubCard(
                          press: () {},
                          bookClub: BookClub.light(
                              1,
                              "Космолюбы ,e,e keejkje ekrj ",
                              "https://fotokonkurs.ru/cache/photo_1000w/photos/2015/11/20/9/03ffc28a9124158ed75bd731f01c527a/1524747579123e8af3f7b1c7346acbb0f9cf4404.jpg",
                              (i % 2).isEven,
                              120,
                              (i % 2 + 1).isEven,
                              ClubTagList(
                                [
                                  ClubTag(2, "Bebebebebebbebebebe"),
                                  ClubTag(2, "Bebebebebebbebebebe"),
                                  ClubTag(2, "Bebebebebebbebebebe"),
                                  ClubTag(2, "Фантастика")
                                ]
                              )
                          ),
                        ),
                      // for (BookReview review in reviewList.reviews)
                      //   ReviewCard(review: review)
                    ],
                  ),
                ),

                // second tab bar view widget
                SingleChildScrollView(
                  reverse: false,
                  child: Column(
                    children: [
                      Text('other text')
                      // for (BookQuote quote in quotesList.quotes)
                      //   QuoteCard(quote: quote)
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
