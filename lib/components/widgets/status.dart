import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../models/enums/book_status.dart';
import '../../models/inherited_id.dart';
import '../constants.dart';
import '../image_constants.dart';
import 'dialogs/nothing_found_dialog.dart';

class StatusWidget extends StatefulWidget {
  final int bookId;
  final BookStatus bookState;

  @override
  StatusWidgetState createState() => StatusWidgetState();

  const StatusWidget({Key? key, required this.bookState, required this.bookId})
      : super(key: key);
}

class StatusWidgetState extends State<StatusWidget> {
  BookStatus bookState = BookStatus.None;
  late int id;

  StatusWidgetState();

  @override
  void initState() {
    super.initState();
    bookState = widget.bookState;
  }

  Future<void> changeStatus(String status) async {
    var client = http.Client();
    final jsonString =
        json.encode({"bookId": widget.bookId, "bookStatus": status});
    try {
      var response = await client.post(
          Uri.https(url, '/interactions/books/update-status'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          },
          body: jsonString);
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) => const Center(
                child: NothingFoundDialog(
                    'Что-то пошло не так!\nСтатус не был изменен.',
                    warningGif,
                    'Ошибка')));
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    return GestureDetector(
        onTap: () {
          setState(() {
            if (bookState == BookStatus.None) {
              bookState = BookStatus.Planning;
            } else {
              bookState = BookStatus.None;
            }
            changeStatus(getStringStat(bookState));
          });
        },
        onDoubleTap: () {
          setState(() {
            if (bookState != BookStatus.Finished) {
              bookState = BookStatus.Finished;
              changeStatus(getStringStat(bookState));
            }
          });
        },
        child: SizedBox(
          height: 35,
          width: 35,
          child: Image.asset(getStateIcon(bookState)),
        ));
  }

  String getStateIcon(BookStatus status) {
    switch (status) {
      case BookStatus.None:
        return 'assets/icons/add.png';
      case BookStatus.InProgress:
        return 'assets/icons/in_prog.png';
      case BookStatus.Finished:
        return 'assets/icons/finished.png';
      case BookStatus.Planning:
        return 'assets/icons/planning.png';
      case BookStatus.Dropped:
        return 'assets/icons/dropped.png';
    }
  }

  String getStringStat(BookStatus status) {
    switch (status) {
      case BookStatus.None:
        return 'None';
      case BookStatus.InProgress:
        return 'InProgress';
      case BookStatus.Finished:
        return 'Finished';
      case BookStatus.Planning:
        return 'Planning';
      case BookStatus.Dropped:
        return 'Dropped';
    }
  }
}
