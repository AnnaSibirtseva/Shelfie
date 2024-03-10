import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/constants.dart';
import '../../components/image_constants.dart';
import '../../components/widgets/cards/serch_club_card.dart';
import '../../components/widgets/dialogs/add_book_club_dialog.dart';
import '../../components/widgets/dialogs/book_club_filter_dialog.dart';
import '../../components/widgets/error.dart';
import '../../components/widgets/loading.dart';
import '../../components/widgets/nothing_found.dart';
import '../../models/book_club.dart';
import '../../models/inherited_id.dart';

import '../../components/routes/route.gr.dart';

class BookClubsPage extends StatefulWidget {
  const BookClubsPage({Key? key}) : super(key: key);

  @override
  State<BookClubsPage> createState() => _ClubsSearchPage();
}

class _ClubsSearchPage extends State<BookClubsPage>
    with SingleTickerProviderStateMixin {
  late int id;
  late TabController _tabController;
  late List<BookClub> _userClubs;
  late List<BookClub> _allClubs;

  late String query;
  late List<String> tags;
  late int membersAmount;

  late BookClubFiltersDialog dialog;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
    query = '';
    tags = [];
    membersAmount = 0;
    dialog = BookClubFiltersDialog();
  }

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
      var response = await client
          .post(Uri.https(url, '/clubs/search/'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                'userId': id.toString(),
                'getPersonalClubs': getPersonalClubs.toString()
              },
              body: jsonString)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return BookClubsList.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .clubs;
      } else {
        throw Exception();
      }
    } on TimeoutException catch (_) {
      throw TimeoutException(
          "Превышел лимит ожидания ответа от сервера.\nПопробуйте позже, сейчас хостинг перезагружается - это может занять какое-то время");
    } finally {
      client.close();
    }
  }

  FutureOr onGoBack(dynamic value) {
    context.router.pushNamed('/home');
    context.router.push(const BookClubsRoute());
    setState(() {});
  }

  FutureOr setFilters(dynamic value) {
    tags = dialog.getSelectedTags();
    membersAmount = dialog.slider.getRating().round();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;
    // keyboard ScrollViewDismissBehavior on drag
    return FutureBuilder<List<List<BookClub>>>(
        future: Future.wait([searchBookClubs(true), searchBookClubs(false)]),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<BookClub>>> snapshot) {
          if (snapshot.hasData) {
            _userClubs = snapshot.data![0];
            _allClubs = snapshot.data![1];
            return SafeArea(
                child: Scaffold(
              body: SingleChildScrollView(
                reverse: false,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                //dialog.privacy = FilterList(data: privacy);
                                return dialog;
                              }).then(setFilters),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, bottom: 20, top: 30),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: size.width * 0.15,
                            height: size.width * 0.15,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: primaryColor, width: 1.5)),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  Image.asset('assets/icons/blue_filter.png'),
                            ),
                          ),
                        ),
                        // const FilterButton(
                        //   pressed: false,
                        // ),
                        searchField(size),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, bottom: size.height * 0.01),
                      height: size.height * 0.9,
                      width: size.width,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          buildInteractionsTabBar(context),
                          if (snapshot.data!.isEmpty) nothingFound(),
                          // for (int i = 0; i < snapshot.data!.length; ++i)
                          //   if (snapshot.data!.length > i)
                          //     ListBookCard(
                          //       press: () => (context.router
                          //           .push(BookInfoRoute(
                          //           bookId: snapshot.data![i].getId()))
                          //           .then(onGoBack)),
                          //       book: snapshot.data![i],
                          //     )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
          } else if (snapshot.hasError) {
            return const WebErrorWidget(errorMessage: noInternetErrorMessage);
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }

  Widget searchField(Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 20),
      padding: const EdgeInsets.only(left: 20, right: 7, top: 5, bottom: 5),
      width: size.width * 0.71,
      height: size.width * 0.15,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor, width: 1.5)),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          query = value;
          setState(() {});
        },
        //controller: _searchController,
        style: const TextStyle(fontSize: 20),
        cursorColor: primaryColor,
        decoration: const InputDecoration(
          suffixIcon: Icon(
            Icons.search_rounded,
            color: grayColor,
            size: 35,
          ),
          hintStyle: TextStyle(color: grayColor, fontSize: 20),
          hintText: 'Найти клуб...',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget nothingFound() {
    return Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.network(
              nothingFoundImg,
              height: 300,
              width: 300,
            ),
            const Text(
              'Ой!\nНе удалось найти ничего по вашему запросу.\n',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
            ),
          ],
        ));
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
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AddBookClubDialog(id: inheritedWidget.id)).then(onGoBack),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
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
                      if (_userClubs.isEmpty)
                        const NothingFoundWidget(
                          image: noTop10,
                          message: "У вас еще нет книжных клубов",
                          space: false,
                        ),
                      if (_userClubs.isNotEmpty)
                        for (int i = 0; i < _userClubs.length; ++i)
                          SearchBookClubCard(
                            press: () => (context.router.push(BookClubInfoRoute(
                                bookId: _userClubs[i].getId()))),
                            bookClub: _userClubs[i],
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
                      for (int i = 0; i < _allClubs.length; ++i)
                        SearchBookClubCard(
                          press: () => (context.router.push(
                              BookClubInfoRoute(bookId: _allClubs[i].getId()))),
                          bookClub: _allClubs[i],
                        ),
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
