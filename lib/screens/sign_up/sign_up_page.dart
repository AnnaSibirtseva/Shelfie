import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../components/routes/route.gr.dart';

import 'components/body.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: SingleChildScrollView(reverse: false, child: Body())));
  }
}
