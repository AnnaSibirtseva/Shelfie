import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/models/book.dart';

import 'package:http/http.dart' as http;
import 'package:shelfie/models/book_status.dart';
import 'dart:convert';

import '../../../../../models/inherited_id.dart';

class StatusTabBar extends StatefulWidget {
  final Book book;

  const StatusTabBar({Key? key, required this.book}) : super(key: key);

  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<StatusTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabsText = ['Буду', 'Читаю', 'Перестал', 'Прочитал', 'Не читаю'];
  late int id;

  @override
  void initState() {
    _tabController = TabController(
        length: 5,
        vsync: this,
        initialIndex: getStateIcon(widget.book.getStatus()));
    super.initState();
    _tabController.addListener(() async {
      await changeStatus(getStatFromIndex(_tabController.index));
    });
  }

  Future<void> changeStatus(String status) async {
    var client = http.Client();
    final jsonString =
        json.encode({"bookId": widget.book.getId(), "bookStatus": status});
    try {
      var response = await client.post(
          Uri.https(url, '/interactions/books/update-status'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          },
          body: jsonString);
      if (response.statusCode != 200) {
        //TODO: show message
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return Container(
      height: size.height * 0.1,
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              isScrollable: true,
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
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              tabs: [
                for (String tab in tabsText)
                  Tab(
                    text: tab,
                  )
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

  String getStatFromIndex(int index) {
    switch (index) {
      case 0:
        return 'Planning';
      case 1:
        return 'InProgress';
      case 2:
        return 'Dropped';
      case 3:
        return 'Finished';
      default:
        return 'None';
    }
  }
}
