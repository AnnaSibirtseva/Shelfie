import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import '../../../../components/routes/route.gr.dart';
import 'body.dart';
//import '../../../../models/user_books.dart';

class UserBooksPage extends StatefulWidget {
  const UserBooksPage({Key? key}) : super(key: key);

  @override
  State<UserBooksPage> createState() => _UserBooksPage();
}

class _UserBooksPage extends State<UserBooksPage> {
  //late Future<UserBookssList> _futureBooksList;

  @override
  void initState() {
    super.initState();
    //_futureBooksList = getUserBookssList();
  }

  // Future<UserBookssList> getUserBookssList() async {
  //   var client = http.Client();
  //   try {
  //     var response =
  //     await client.get(Uri.http(url, '/interactions/Bookss/by-user/${1}'));
  //     if (response.statusCode == 200) {
  //       return UserBookssList.fromJson(
  //           jsonDecode(utf8.decode(response.bodyBytes)));
  //     } else {
  //       throw Exception();
  //     }
  //   } finally {
  //     client.close();
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
          reverse: false,
          child: Body()),
    );

    // return FutureBuilder<UserBookssList>(
    //     future: _futureBooksList,
    //     builder:
    //         (BuildContext context, AsyncSnapshot<UserBookssList> snapshot) {
    //       if (snapshot.hasData) {
    //         return Scaffold(
    //           body: SingleChildScrollView(
    //               reverse: false,
    //               child: Body(
    //                 Bookss: (snapshot.data!).Bookss,
    //               )),
    //         );
    //       } else if (snapshot.hasError) {
    //         return WebErrorWidget(errorMessage: snapshot.error.toString());
    //       } else {
    //         // By default, show a loading spinner.
    //         return const LoadingWidget();
    //       }
    //     });
  }
}
