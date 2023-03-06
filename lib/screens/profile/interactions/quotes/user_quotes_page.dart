import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import '../../../../models/user_quote.dart';
import 'body.dart';

class UserQuotesPage extends StatefulWidget {
  const UserQuotesPage({Key? key}) : super(key: key);

  @override
  State<UserQuotesPage> createState() => _UserQuotesPage();
}

class _UserQuotesPage extends State<UserQuotesPage> {
  late Future<UserQuotesList> _futureQuotesList;

  @override
  void initState() {
    super.initState();
    _futureQuotesList = getQuotesList();
  }

  Future<UserQuotesList> getQuotesList() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.http(url, '/interactions/quotes/by-user/${1}'));
      if (response.statusCode == 200) {
        return UserQuotesList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserQuotesList>(
        future: _futureQuotesList,
        builder: (BuildContext context, AsyncSnapshot<UserQuotesList> snapshot) {
          if (snapshot.hasData) {
            print((snapshot.data!).quotes);
            return Scaffold(
              body: SingleChildScrollView(
                  reverse: false,
                  child: Body(quotes: (snapshot.data!).quotes,)
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
