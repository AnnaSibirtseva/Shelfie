import 'package:flutter/cupertino.dart';

import '../constants.dart';

class WebErrorWidget extends StatelessWidget {
  final double size;
  final String errorMessage;

  const WebErrorWidget({
    Key? key,
    this.errorMessage = 'Something went wrong',
    this.size = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/no_internet.png",
            height: size,
            width: size,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w900,
                  color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
