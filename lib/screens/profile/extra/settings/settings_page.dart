import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  @override
  void initState() {
    super.initState();
  }

  // Future<UserBookssList> getUserBookssList() async {
  //   var client = http.Client();
  //   try {
  //     var response =
  //     await client.get(Uri.http(url, '/interactions/Bookss/by-user/${1}'));
  //     if (response.statusCode == 200) {
  //       return UserBookssList.fromJson(
  //           jsonDecode(utf8.decode(response.bodyBytes)));
  //     } else {
  //       throw Exception();
  //     }
  //   } finally {
  //     client.close();
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
          reverse: false,
          child: Text('Настройки')),
    );
  }
}
