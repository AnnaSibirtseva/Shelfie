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
import 'package:auto_route/auto_route.dart';
import '../../components/routes/route.gr.dart';
import 'tab_bars/search_tab_bar.dart';

class BookClubsPage extends StatefulWidget {
  const BookClubsPage({Key? key}) : super(key: key);

  @override
  State<BookClubsPage> createState() => _ClubsSearchPage();
}

class _ClubsSearchPage extends State<BookClubsPage> {
  late int id;
  late String query;
  late List<String> tags;
  late FiltersDialog dialog;

  @override
  void initState() {
    super.initState();
    query = '';
    tags = [];
    dialog = FiltersDialog();
  }

  Future<List<Book>> searchBooks() async {
    var client = http.Client();
    final jsonString = json.encode({
      "query": query,
      if (tags.isNotEmpty) "tags": tags,
      "take": 500,
      "skip": 0
    });
    try {
      var response = await client.post(Uri.https(url, '/books/search/'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          },
          body: jsonString);
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
    context.router.pushNamed('/bookClubs');
    context.router.push(const SearchRouter());
    setState(() {});
  }

  FutureOr setFilters(dynamic value) {
    tags = dialog.getSelectedCountries();
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
                    Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, bottom: size.height * 0.01),
                      height: size.height * 1.5,
                      width: size.width,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          SearchTabBar(),
                          if (snapshot.data!.isEmpty) nothingFound(),
                          // for (int i = 0; i < snapshot.data!.length; ++i)
                          //   if (snapshot.data!.length > i)
                          //     ListBookCard(
                          //       press: () => (context.router
                          //           .push(BookInfoRoute(
                          //           bookId: snapshot.data![i].getId()))
                          //           .then(onGoBack)),
                          //       book: snapshot.data![i],
                          //     )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
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
          hintText: 'Найти клуб...',
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
              'Ой!\nНе удалось найти ничего по вашему запросу.\n',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
