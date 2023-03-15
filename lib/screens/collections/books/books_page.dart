import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import '../../../components/routes/route.gr.dart';

class CollectionBooksPage extends StatefulWidget {
  const CollectionBooksPage({Key? key}) : super(key: key);

  @override
  State<CollectionBooksPage> createState() => _CollectionBooksPage();
}

class _CollectionBooksPage extends State<CollectionBooksPage> {

  @override
  void initState() {
    super.initState();
  }
  //
  // Future<List<Book>> searchBooks(int id) async {
  //   var client = http.Client();
  //   try {
  //     var response = await client.get(
  //         Uri.https(url, '/books/search/', {'take': '10'}),
  //         headers: {'userId': id.toString()});
  //     if (response.statusCode == 200) {
  //       return BookList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
  //           .foundBooks;
  //     } else {
  //       throw Exception();
  //     }
  //   } finally {
  //     client.close();
  //   }
  // }

  // FutureOr onGoBack(dynamic value) {
  //   context.router.navigate(const SearchRouter());
  //   context.router.pushNamed('/home');
  //   context.router.push(const SearchRouter());
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    //final inheritedWidget = IdInheritedWidget.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: false,
        child: Text('Book')
      ),
    );

      // FutureBuilder<List<Book>>(
      //   future: searchBooks(inheritedWidget.id),
      //   builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
      //     if (snapshot.hasData) {
      //       return Scaffold(
      //         body: SingleChildScrollView(
      //           reverse: false,
      //           child:Column(
      //                 children: [
      //                   for (int i = 0; i < snapshot.data!.length; ++i)
      //                     if (snapshot.data!.length > i)
      //                       ListBookCard(
      //                         press: () => (context.router.push(
      //                             BookInfoRoute(bookId: snapshot.data![i].getId())).then(onGoBack)),
      //                         book: snapshot.data![i],
      //                       )
      //                 ],
      //           ),
      //         ),
      //       );
      //     } else if (snapshot.hasError) {
      //       return WebErrorWidget(errorMessage: snapshot.error.toString());
      //     } else {
      //       // By default, show a loading spinner.
      //       return const LoadingWidget();
      //     }
      //   });
  }
}
