import 'package:flutter/material.dart';
import '../../../models/inherited_id.dart';

class BookClubInfoPage extends StatefulWidget {
  final int bookId;

  const BookClubInfoPage(this.bookId, {Key? key}) : super(key: key);

  @override
  State<BookClubInfoPage> createState() => _BookClubInfoPage();
}

class _BookClubInfoPage extends State<BookClubInfoPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    return const SingleChildScrollView(
      reverse: false,
      child: Center(child: Text("CLUB INFO PAGE")),
    );
  }
}
