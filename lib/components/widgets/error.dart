import 'package:flutter/cupertino.dart';

import '../constants.dart';

class WebErrorWidget extends StatelessWidget {
  final String errorMessage;

  const WebErrorWidget({
    Key? key,
    this.errorMessage = 'Something went wrong',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/error.png",
            ),
            Text(
              errorMessage,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w900,
                  color: primaryColor),
            ),
          ],
        ),
    );
  }
}
