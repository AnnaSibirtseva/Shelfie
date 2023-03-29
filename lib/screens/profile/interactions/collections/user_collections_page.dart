import 'package:flutter/material.dart';
import 'body.dart';

class UserCollectionsPage extends StatefulWidget {
  const UserCollectionsPage({Key? key}) : super(key: key);

  @override
  State<UserCollectionsPage> createState() => _UserCollectionsPage();
}

class _UserCollectionsPage extends State<UserCollectionsPage> {
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
