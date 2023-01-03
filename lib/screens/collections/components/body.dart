import 'package:flutter/material.dart';

import '../../../models/collection.dart';
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
            press: () => {},
            collection: collection[index],
          ),
        ),
      )
    );
  }
}
