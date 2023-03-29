import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import '../../../../models/inherited_id.dart';
import '../../../../models/user_quote.dart';
import 'body.dart';

class UserQuotesPage extends StatefulWidget {
  const UserQuotesPage({Key? key}) : super(key: key);

  @override
  State<UserQuotesPage> createState() => _UserQuotesPage();
}

class _UserQuotesPage extends State<UserQuotesPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<UserQuotesList> getQuotesList(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.http(url, '/interactions/quotes/', {'take': '50'}),
          headers: {'userId': id.toString()});
      if (response.statusCode == 200) {
        return UserQuotesList.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    return FutureBuilder<UserQuotesList>(
        future: getQuotesList(inheritedWidget.id),
        builder:
            (BuildContext context, AsyncSnapshot<UserQuotesList> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                  reverse: false,
                  child: Body(
                    quotes: (snapshot.data!).quotes,
                  )),
            );
          } else if (snapshot.hasError) {
            return WebErrorWidget(errorMessage: snapshot.error.toString());
          } else {
            return const LoadingWidget();
          }
        });
  }
}
