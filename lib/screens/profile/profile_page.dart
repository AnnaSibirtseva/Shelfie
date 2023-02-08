import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/components/widgets/loading.dart';
import 'package:shelfie/models/user.dart';
import '../../components/routes/route.gr.dart';
import 'body.dart';

late final User user;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = getUser();
  }

  Future<User> getUser() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.http(url, '/users/profile/${1}'));
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: _futureUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data!;
            return const Scaffold(
                body: SingleChildScrollView(reverse: false, child: Body()));
          } else if (snapshot.hasError) {
            return WebErrorWidget(errorMessage: snapshot.error.toString());
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }
}
