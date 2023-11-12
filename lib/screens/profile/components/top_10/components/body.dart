import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../components/constants.dart';
import '../../../../../components/image_constants.dart';
import '../../../../../components/routes/route.gr.dart';
import '../../../../../components/widgets/error.dart';
import '../../../../../components/widgets/nothing_found.dart';
import '../../../../../models/top-10_book.dart';
import '../../../../../components/widgets/loading.dart';
import '../../../../../models/inherited_id.dart';
import '../../../interactions/header_widget.dart';
import 'top_10_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List<Top10BookInfo>> getTop10(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https(url, '/books/top/${id.toString()}/detailed'),
        //headers: {'userId': id.toString()}
      );
      if (response.statusCode == 200) {
        return Top10BookList.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .allBooks;
      } else {
        throw Exception('Не удалось получить информацию о топе пользователя.');
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
    Size size = MediaQuery.of(context).size;
    final inheritedWidget = IdInheritedWidget.of(context);

    return FutureBuilder<List<Top10BookInfo>>(
        future: getTop10(inheritedWidget.id),
        builder: (BuildContext context,
            AsyncSnapshot<List<Top10BookInfo>> snapshot) {
          if (snapshot.hasData) {
            List<Top10BookInfo> top10books = snapshot.data!;
            return Container(
                margin: EdgeInsets.only(top: 15, bottom: size.height * 0.1),
                height: size.height * 0.85,
                width: size.width,
                child: SingleChildScrollView(
                  reverse: false,
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: HeaderWidget(
                        text: 'Топ-10',
                        icon: 'book',
                      ),
                    ),
                    if (top10books.isEmpty)
                      const NothingFoundWidget(
                        image: noTop10,
                        message: "Ой!\nУ вас еще нет любимых книг в топе",
                      ),
                    for (int i = 0; i < top10books.length; ++i)
                      Top10ListCard(
                          press: () => (context.router.push(
                                  BookInfoRoute(bookId: top10books[i].getId())))
                              .then(onGoBack),
                          book: top10books[i],
                          index: i + 1),
                  ]),
                ));
          } else if (snapshot.hasError) {
            return Center(
                child: WebErrorWidget(errorMessage: snapshot.error.toString()));
          } else {
            // By default, show a loading spinner.
            return const Center(child: SmallLoadingWidget());
          }
        });
  }
}
