import 'package:flutter/material.dart';

import '../../../models/collection.dart';

class Body extends StatelessWidget {
  final List<Collection> collection;

  const Body({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: size.height * 0.1),
          // Expanded(
          //   child: ListView.builder(
          //     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag
          //     itemCount: collection.length,
          //     itemBuilder: (context, index) => CollectionCard(
          //       press: () => {},
          //       collection: collection[index],
          //     ),
          //   ),
          // ),
          SizedBox(height: size.height * 0.1),
        ],
      ),
    );
  }
}
