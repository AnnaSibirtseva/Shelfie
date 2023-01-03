import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/constants.dart';
import '../../components/widgets/error.dart';
import '../../components/widgets/loading.dart';
import '../../models/collection.dart';
import 'components/body.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  State<CollectionsPage> createState() => _CollectionsPage();
}

class _CollectionsPage extends State<CollectionsPage> {
  late Future<List<Collection>> _futureCollections;

  @override
  void initState() {
    super.initState();
    _futureCollections = getCollections();
  }

  Future<List<Collection>> getCollections() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.http(url, '/shelves/collections/common', {'take': '10'}));
      if (response.statusCode == 200) {
        return RecommendedCollections.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .collections;
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Collection>>(
        future: _futureCollections,
        builder:
            (BuildContext context, AsyncSnapshot<List<Collection>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                reverse: false,
                child: Body(
                  collection: snapshot.data!,
                ));
          } else if (snapshot.hasError) {
            return WebErrorWidget(errorMessage: snapshot.error.toString());
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }
}
