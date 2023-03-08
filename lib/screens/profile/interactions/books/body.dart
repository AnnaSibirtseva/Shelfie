import 'package:flutter/material.dart';

import '../header_widget.dart';

class Body extends StatelessWidget {

  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.only(
          left: 15, right: 15, top: 15, bottom: size.height * 0.1),
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          const HeaderWidget(
              text: 'Книги',
              icon: 'book',),
        ],
      ),
    );
  }
}
