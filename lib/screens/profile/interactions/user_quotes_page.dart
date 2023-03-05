import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import 'package:shelfie/models/user.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/dialogs/add_quote_dialog.dart';
import 'header_widget.dart';

class UserQuotesPage extends StatefulWidget {
  const UserQuotesPage({Key? key}) : super(key: key);

  @override
  State<UserQuotesPage> createState() => _UserQuotesPage();
}

class _UserQuotesPage extends State<UserQuotesPage> {
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = getUser();
  }

  Future<User> getUser() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.http(url, '/users/profile/${1}'));
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        reverse: false,
        child: GestureDetector(
          onTap: () => showDialog(context: context, builder: (BuildContext context) => AddQuoteDialog()),
          child: HeaderWidget(
            text: 'Цитаты',
            icon: 'quote',
          ),
        )

      ),
    );

    // FutureBuilder<User>(
    //   future: _futureUser,
    //   builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
    //     if (snapshot.hasData) {
    //       return Scaffold(
    //           body: SingleChildScrollView(reverse: false, child: ));
    //     } else if (snapshot.hasError) {
    //       return WebErrorWidget(errorMessage: snapshot.error.toString());
    //     } else {
    //       // By default, show a loading spinner.
    //       return const LoadingWidget();
    //     }
    //   });
  }
}
