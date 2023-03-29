import 'package:flutter/material.dart';
import 'body.dart';

class UserBooksPage extends StatefulWidget {
  const UserBooksPage({Key? key}) : super(key: key);

  @override
  State<UserBooksPage> createState() => _UserBooksPage();
}

class _UserBooksPage extends State<UserBooksPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(reverse: false, child: Body()),
    );
  }
}
