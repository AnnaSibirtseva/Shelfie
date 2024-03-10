import 'package:flutter/material.dart';

import '../constants.dart';

class NothingFoundWidget extends StatelessWidget {
  final String image;
  final String message;
  final bool space;

  const NothingFoundWidget(
      {Key? key, required this.image, required this.message, required this.space})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: space ? size.height * 0.1 : 0,
            ),
            Image.network(
              image,
              //height: size.height * 0.5,
              width: size.width * 0.85,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                  color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
