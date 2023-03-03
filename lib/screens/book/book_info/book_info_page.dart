import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import '../../../components/routes/route.gr.dart';
import 'components/body.dart';

class BookInfoPage extends StatefulWidget {
  const BookInfoPage({Key? key}) : super(key: key);

  @override
  State<BookInfoPage> createState() => _BookInfoPage();
}

class _BookInfoPage extends State<BookInfoPage> {
  //late Future<List<Collection>> _futureCollections;

  @override
  void initState() {
    super.initState();
    //_futureCollections = getCollections();
  }

  //
  // Future<List<Collection>> getCollections() async {
  //   var client = http.Client();
  //   try {
  //     var response = await client
  //         .get(Uri.http(url, '/shelves/collections/common', {'take': '10'}));
  //     if (response.statusCode == 200) {
  //       return RecommendedCollections.fromJson(
  //           jsonDecode(utf8.decode(response.bodyBytes)))
  //           .collections;
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
      body: Center(
        child: SingleChildScrollView(
          reverse: false,
          child: Body(),
        ),
      ),
    );
  }
}
