import 'package:flutter/cupertino.dart';

import '../constants.dart';

class GenreWidget extends StatelessWidget {
  final String genreName;

  const GenreWidget({super.key, required this.genreName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      //margin: const EdgeInsets.only(top: 10, right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(
        genreName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
      ),
    );
  }
}
