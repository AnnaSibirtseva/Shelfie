import 'package:flutter/material.dart';

import '../../components/widgets/cards/top_10_card_light.dart';

class BookClubsPage extends StatefulWidget {
  const BookClubsPage({Key? key}) : super(key: key);

  @override
  State<BookClubsPage> createState() => _BookClubsPage();
}

class _BookClubsPage extends State<BookClubsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        reverse: false,
        child: Center(
            child: Container(
          margin: EdgeInsets.only(
              left: 5, right: 5, top: 25, bottom: size.height * 0.1),
          height: size.height,
          width: size.width,
          child: Text("Book Clubs"),
        )));
  }
}
