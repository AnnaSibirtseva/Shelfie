import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/models/book.dart';
import '../../../components/constants.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/loading.dart';
import '../../../models/inherited_id.dart';
import 'components/body.dart';

class BookInfoPage extends StatefulWidget {
  final int bookId;

  const BookInfoPage(
    this.bookId, {
    Key? key,
  }) : super(key: key);

  @override
  State<BookInfoPage> createState() => _BookInfoPage();
}

class _BookInfoPage extends State<BookInfoPage> {
  late int bookId;

  @override
  void initState() {
    super.initState();
    bookId = widget.bookId;
  }

  Future<Book> getAllBookInfo(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(url, '/books/books/$bookId'),
          headers: {'userId': id.toString()});
      if (response.statusCode == 200) {
        return Book.allInfoFromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception('Не удалось получить информацию о книге.');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    return FutureBuilder<Book>(
        future: getAllBookInfo(inheritedWidget.id),
        builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
               body: SingleChildScrollView(
                  reverse: false,
                  child: Body(book: snapshot.data!),

              ),
            );
          } else if (snapshot.hasError) {
            return WebErrorWidget(errorMessage: snapshot.error.toString());
          } else {
            return const LoadingWidget();
          }
        });
  }
}
