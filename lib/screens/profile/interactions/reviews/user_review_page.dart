import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../components/constants.dart';
import '../../../../components/widgets/error.dart';
import '../../../../components/widgets/loading.dart';
import '../../../../models/inherited_id.dart';
import '../../../../models/user_review.dart';
import 'body.dart';

class UserReviewPage extends StatefulWidget {
  const UserReviewPage({Key? key}) : super(key: key);

  @override
  State<UserReviewPage> createState() => _UserReviewPage();
}

class _UserReviewPage extends State<UserReviewPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<UserReviewsList> getUserReviewsList(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.http(url, '/interactions/reviews/'),
          headers: {'userId': id.toString()});
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
    final inheritedWidget = IdInheritedWidget.of(context);
    return FutureBuilder<UserReviewsList>(
        future: getUserReviewsList(inheritedWidget.id),
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
