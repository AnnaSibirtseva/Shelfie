import 'package:flutter/material.dart';

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
    return const SingleChildScrollView(
                reverse: false,
                child: Text("BOOK CLUBS",
                ));
  }
}
