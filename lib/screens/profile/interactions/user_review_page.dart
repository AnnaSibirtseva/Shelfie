import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import 'package:shelfie/models/user.dart';
import '../../../components/routes/route.gr.dart';
import 'header_widget.dart';

class UserReviewPage extends StatefulWidget {
  const UserReviewPage({Key? key}) : super(key: key);

  @override
  State<UserReviewPage> createState() => _UserReviewPage();
}

class _UserReviewPage extends State<UserReviewPage> {
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
            child: HeaderWidget(
              text: 'Рецензии',
              icon: 'review',
            )));

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
