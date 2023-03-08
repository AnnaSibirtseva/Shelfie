import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import '../../../../components/routes/route.gr.dart';
import 'body.dart';
//import '../../../../models/user_collections.dart';

class UserCollectionsPage extends StatefulWidget {
  const UserCollectionsPage({Key? key}) : super(key: key);

  @override
  State<UserCollectionsPage> createState() => _UserCollectionsPage();
}

class _UserCollectionsPage extends State<UserCollectionsPage> {
  //late Future<UserCollectionsList> _futureCollectionsList;

  @override
  void initState() {
    super.initState();
    //_futureCollectionsList = getUserCollectionsList();
  }

  // Future<UserCollectionsList> getUserCollectionsList() async {
  //   var client = http.Client();
  //   try {
  //     var response =
  //     await client.get(Uri.http(url, '/interactions/Collections/by-user/${1}'));
  //     if (response.statusCode == 200) {
  //       return UserCollectionsList.fromJson(
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

    // return FutureBuilder<UserCollectionsList>(
    //     future: _futureCollectionsList,
    //     builder:
    //         (BuildContext context, AsyncSnapshot<UserCollectionsList> snapshot) {
    //       if (snapshot.hasData) {
    //         return Scaffold(
    //           body: SingleChildScrollView(
    //               reverse: false,
    //               child: Body(
    //                 Collections: (snapshot.data!).Collections,
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
