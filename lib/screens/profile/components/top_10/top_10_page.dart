import 'package:flutter/material.dart';

import 'components/body.dart';

class Top10Page extends StatefulWidget {
  const Top10Page({Key? key}) : super(key: key);

  @override
  State<Top10Page> createState() => _Top10Page();
}

class _Top10Page extends State<Top10Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(reverse: false, child: Body());
  }
}
