import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../components/constants.dart';
import '../../../components/widgets/error.dart';
import '../../../components/widgets/loading.dart';
import '../../../models/book.dart';
import '../../../models/inherited_id.dart';

class BookInfoPage extends StatefulWidget {
  final int bookId;

  const BookInfoPage(this.bookId, {Key? key}) : super(key: key);

  @override
  State<BookInfoPage> createState() => _BookInfoPage();
}

class _BookInfoPage extends State<BookInfoPage> {


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
