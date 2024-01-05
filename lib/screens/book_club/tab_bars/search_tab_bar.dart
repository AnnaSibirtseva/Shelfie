import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie_diploma_app/components/routes/route.gr.dart';
import 'dart:convert';

import '../../../../../components/constants.dart';
import '../../../../../components/widgets/cards/quote_card.dart';
import '../../../../../components/widgets/cards/review_card.dart';
import '../../../../../components/widgets/dialogs/add_book_dialog.dart';
import '../../../../../components/widgets/dialogs/add_quote_dialog.dart';
import '../../../../../components/widgets/dialogs/add_review_dialog.dart';
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
  late int id;
  late String query;
  late List<String> tags;
  late int membersAmount;
  //late FiltersDialog dialog;

  Future<List<BookClub>> searchBookClubs(bool getPersonalClubs) async {
    var client = http.Client();
    final jsonString = json.encode({
      "query": query,
      "membersAmount": membersAmount,
      if (tags.isNotEmpty) "tags": tags,
      "take": 500,
      "skip": 0
    });
    try {
      var response = await client.post(Uri.https(url, '/books/search/'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString(),
            'getPersonalClubs': getPersonalClubs.toString()
          },
          body: jsonString);
      if (response.statusCode == 200) {
        return BookClubsList.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .clubs;
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

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
    //_userClubsList = getUserClubsList();
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
                  tabs: const [
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
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              // showDialog(
              // context: context,
              // builder: (BuildContext context) =>
              //     AddReviewDialog(
              //         book: widget.book,
              //         id: inheritedWidget.id)),
              // .then(onReviewsGoBack),
              child: const Text('Добавить клуб',
                  style: TextStyle(color: grayColor)),
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
                          press: () => (context.router
                              .push(BookClubInfoRoute(bookId: 1))),
                          bookClub: BookClub.light(
                              1,
                              "Космолюбы ,e,e keejkje ekrj ",
                              "6acbb0f9cf4404.jpg",
                              (i % 2).isEven,
                              120,
                              (i % 2 + 1).isEven,
                              ClubTagList([
                                ClubTag(2, "Bebebebebebbebebebe"),
                                ClubTag(2, "Bebebebebebbebebebe"),
                                ClubTag(2, "Bebebebebebbebebebe"),
                                ClubTag(2, "Фантастика")
                              ])),
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
