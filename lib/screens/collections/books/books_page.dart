import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../components/constants.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/error.dart';
import '../../../components/widgets/loading.dart';
import '../../../models/book.dart';
import '../../../models/inherited_id.dart';
import '../../search/components/list_book_card.dart';

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
              {'take': '50'}),
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
    context.router.navigate(const CollectionsRouter());
    context.router.pushNamed('/home');
    context.router.push(const CollectionsRouter());
    context.router.push(CollectionBooksRoute(
        collectionId: widget.collectionId,
        collectionName: widget.collectionName));
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
              body: SafeArea(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                            width: size.width * 0.09,
                            child: Image.asset('assets/images/book_shelf.png'),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextScroll(
                                widget.collectionName,
                                intervalSpaces: 5,
                                velocity: const Velocity(
                                    pixelsPerSecond: Offset(50, 0)),
                                fadedBorder: true,
                                fadeBorderVisibility:
                                FadeBorderVisibility.auto,
                                fadeBorderSide: FadeBorderSide.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: blackColor,
                                    fontSize: size.width / 14)),
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
