import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:shelfie/models/book.dart';
import 'package:shelfie/models/inherited_id.dart';
import 'package:shelfie/screens/search/components/list_book_card.dart';
import '../../../components/routes/route.gr.dart';

class CollectionBooksPage extends StatefulWidget {
  final int collectionId;
  final String collectionName;

  const CollectionBooksPage(this.collectionId, this.collectionName, {Key? key})
      : super(key: key);

  @override
  State<CollectionBooksPage> createState() => _CollectionBooksPage();
}

class _CollectionBooksPage extends State<CollectionBooksPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Book>> getCollectionBooks(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(
              url,
              '/shelves/collections/${widget.collectionId.toString()}',
              {'take': '20'}),
          headers: {'userId': id.toString()});
      if (response.statusCode == 200) {
        return BookList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
            .foundBooks;
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Book>>(
        future: getCollectionBooks(inheritedWidget.id),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                reverse: false,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 15,
                          height: 15,
                        ),
                        SizedBox(
                          height: size.height * 0.09,
                          width: size.width * 0.09,
                          child: Image.asset('assets/images/book_shelf.png'),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            widget.collectionName,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'VelaSansExtraBold',
                                fontSize: size.width / 14,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    for (int i = 0; i < snapshot.data!.length; ++i)
                      if (snapshot.data!.length > i)
                        ListBookCard(
                          press: () => (context.router
                              .push(BookInfoRoute(
                                  bookId: snapshot.data![i].getId()))
                              .then(onGoBack)),
                          book: snapshot.data![i],
                        )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return WebErrorWidget(errorMessage: snapshot.error.toString());
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }
}
