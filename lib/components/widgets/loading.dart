import 'package:flutter/material.dart';

import '../constants.dart';
import '../image_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              shelvesGif,
              height: 125.0,
              width: 125.0,
            ),
            const Text(
              'Загрузка...',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                  color: blackColor),
            ),
          ],
        ),
      ),
    );
  }
}
