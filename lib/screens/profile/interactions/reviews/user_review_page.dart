import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import '../../../../components/routes/route.gr.dart';
import '../../../../models/user_review.dart';
import 'body.dart';

class UserReviewPage extends StatefulWidget {
  const UserReviewPage({Key? key}) : super(key: key);

  @override
  State<UserReviewPage> createState() => _UserReviewPage();
}

class _UserReviewPage extends State<UserReviewPage> {
  late Future<UserReviewsList> _futureReviewList;

  @override
  void initState() {
    super.initState();
    _futureReviewList = getUserReviewsList();
  }

  Future<UserReviewsList> getUserReviewsList() async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.http(url, '/interactions/reviews/by-user/${1}'));
      if (response.statusCode == 200) {
        return UserReviewsList.fromJson(
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
    return FutureBuilder<UserReviewsList>(
        future: _futureReviewList,
        builder:
            (BuildContext context, AsyncSnapshot<UserReviewsList> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                  reverse: false,
                  child: Body(
                    reviews: (snapshot.data!).reviews,
                  )),
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
