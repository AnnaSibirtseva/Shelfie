import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import 'package:shelfie/models/book_status.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie/models/inherited_id.dart';
import 'dart:convert';

import 'package:shelfie/models/user_book.dart';

class BooksTabBar extends StatefulWidget {
  const BooksTabBar({Key? key}) : super(key: key);

  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<BooksTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabsText = ['Буду', 'Читаю', 'Перестал', 'Прочитал'];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  String getStatusFromTab() {
    switch (_tabController.index) {
      case 0:
        return 'Planning';
      case 1:
        return 'InProgress';
      case 2:
        return 'Dropped';
      default:
        return 'Finished';
    }
  }

  Future<List<UserBook>> getAllBooks(int id, take, skip) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/interactions/books/by-status}', {
            'status': getStatusFromTab(),
            'take': take.toString(),
            'skip': skip.toString()
          }),
          headers: {'userId': id.toString()});
      if (response.statusCode == 200) {
        return UserBookList.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .allBooks;
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

    return Container(
      height: size.height * 0.1,
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Column(
        children: [
          Container(
              height: 45,
              width: size.width,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: Center(
                child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: primaryColor,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                  tabs: [
                    for (String tab in tabsText)
                      Tab(
                        text: tab,
                      )
                  ],
                ),
              )),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                for (int i = 0; i < 4; ++i)
                  FutureBuilder<List<UserBook>>(
                      future: getAllBooks(inheritedWidget.id, 50, 0),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<UserBook>> snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            reverse: false,
                            child: Column(
                              children: [],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return WebErrorWidget(
                              errorMessage: snapshot.error.toString());
                        } else {
                          return const LoadingWidget();
                        }
                      })
              ],
            ),
          ),
        ],
      ),
    );
  }

  int getStateIcon(BookStatus status) {
    switch (status) {
      case BookStatus.Planning:
        return 0;
      case BookStatus.InProgress:
        return 1;
      case BookStatus.Dropped:
        return 2;
      case BookStatus.Finished:
        return 3;
      case BookStatus.None:
        return 4;
    }
  }
}
