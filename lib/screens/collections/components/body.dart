import 'package:flutter/material.dart';
import 'package:shelfie/components/routes/route.gr.dart';

import '../../../models/collection.dart';
import 'package:auto_route/auto_route.dart';
import 'background.dart';
import 'collection_card.dart';

class Body extends StatelessWidget {
  final List<Collection> collection;

  const Body({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        body: Expanded(
      child: ListView.builder(
        itemCount: collection.length,
        itemBuilder: (context, index) => CollectionCard(
          press: () => (context.router.push(CollectionBooksRoute(
              collectionId: collection[index].getId(),
              collectionName: collection[index].getName()))),
          collection: collection[index],
        ),
      ),
    ));
  }
}
