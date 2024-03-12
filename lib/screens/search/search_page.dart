import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/buttons/scan_button.dart';
import '../../components/constants.dart';
import '../../components/image_constants.dart';
import '../../components/widgets/dialogs/filters_dialog.dart';
import '../../components/widgets/error.dart';
import '../../components/widgets/loading.dart';
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
  late int id;
  late String query;
  late List<String> languages;
  late List<String> genres;
  late List<String> ageRestrictions;
  late int minRating;
  late FiltersDialog dialog;

  @override
  void initState() {
    super.initState();
    query = '';
    languages = [];
    genres = [];
    ageRestrictions = [];
    minRating = 0;
    dialog = FiltersDialog();
  }

  Future<List<Book>> searchBooks(int retry) async {
    var client = http.Client();
    final jsonString = json.encode({
      "query": query,
      if (languages.isNotEmpty) "languages": languages,
      if (genres.isNotEmpty) "genres": genres,
      if (ageRestrictions.isNotEmpty) "ageRestrictions": ageRestrictions,
      "minRating": minRating,
      "take": 500,
      "skip": 0
    });
    try {
      var response = await client
          .post(Uri.https(url, '/books/search/'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                'userId': id.toString()
              },
              body: jsonString)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return BookList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
            .foundBooks;
      } else {
        if (retry != 0) {
          return searchBooks(0);
        }
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
    context.router.navigate(const SearchRouter());
    context.router.pushNamed('/home');
    context.router.push(const SearchRouter());
    setState(() {});
  }

  FutureOr setFilters(dynamic value) {
    genres = dialog.getSelectedGenres();
    ageRestrictions = dialog.getSelectedRestrictions();
    minRating = dialog.getMinRating();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;
    // keyboard ScrollViewDismissBehavior on drag
    return FutureBuilder<List<Book>>(
        future: searchBooks(1),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.hasData) {
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
            Image.network(
              nothingFoundImg,
              height: 300,
              width: 300,
            ),
            const Text(
              'Ой!\nНе удалось найти ничего по вашему запросу.\nПопробуйте отсканировать ISBN.\n',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
