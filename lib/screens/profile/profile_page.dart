import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../components/routes/route.gr.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: SingleChildScrollView(reverse: false, child: Text('!!! PROFILE !!!'))));
  }
}