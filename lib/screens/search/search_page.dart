import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie/components/image_constants.dart';
import 'package:shelfie/components/widgets/dialogs/nothing_found_dialog.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import 'dart:convert';

import '../../components/buttons/filter_button.dart';
import '../../components/buttons/scan_button.dart';
import '../../components/constants.dart';
import '../../models/book.dart';
import '../../models/inherited_id.dart';
import 'components/list_book_card.dart';
import 'package:auto_route/auto_route.dart';
import '../../components/routes/route.gr.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  //final _searchController = TextEditingController();

  late Future<List<Book>> _futureBooks;
  late int id;
  late String query;

  @override
  void initState() {
    super.initState();
    query = '';
    //_futureBooks = searchBooks('');
    //_searchController.addListener(_searchBooks);
  }

  //
  // void _searchBooks() {
  //   final queryText = _searchController.text;
  //   if (queryText.isNotEmpty) {
  //     query = queryText;
  //     //_futureBooks = searchBooks();
  //   }
  //   setState(() {});
  // }

  Future<List<Book>> searchBooks() async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/books/search/', {'query': query, 'take': '50'}),
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
    context.router.navigate(const SearchRouter());
    context.router.pushNamed('/home');
    context.router.push(const SearchRouter());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;
    // keyboard ScrollViewDismissBehavior on drag
    return FutureBuilder<List<Book>>(
        future: searchBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                reverse: false,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        const FilterButton(
                          pressed: false,
                        ),
                        searchField(size),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            ScanButton(),
                          ],
                        ),
                        if (snapshot.data!.isEmpty) nothingFound(),
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
        onSubmitted: (value) {
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
          hintText: 'Найти книгу...',
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
          Image.network(nothingFoundImg, height: 300, width: 300,),
          const Text(
            'Ой!\nНе удалось найти ничего по вашему запросу.\nПопробуйте отсканировать ISBN.\n',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600),
          ),
        ],
      )
    );
  }
}
