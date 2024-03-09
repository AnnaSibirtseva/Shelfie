import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import '../../components/constants.dart';
import '../../components/routes/route.gr.dart';
import '../../components/widgets/dialogs/about_dialog.dart';
import '../../components/widgets/error.dart';
import '../../components/widgets/loading.dart';
import '../../models/inherited_id.dart';
import '../../models/user.dart';
import 'components/menu/menu.dart';
import 'components/profile_head.dart';
import 'components/stats/statistic_row.dart';
import 'components/top_10/menu_top_10_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<User> getUser(int id) async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.http(url, '/users/profile/$id'))
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception();
      }
    } on TimeoutException catch (_) {
      throw TimeoutException(
          "Превышел лимит ожидания ответа от сервера.\nПопробуйте позже, сейчас хостинг перезагружается - это может занять какое-то время");
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    return FutureBuilder<User>(
        future: getUser(inheritedWidget.id),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
                child: Scaffold(
                    body: SingleChildScrollView(
                        reverse: false, child: buildBody(snapshot.data!))));
          } else if (snapshot.hasError) {
            return const WebErrorWidget(errorMessage: noInternetErrorMessage);
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  Widget buildBody(User user) {
    List mainRoutes = [
      // user books page
      () => context.router.push(const UserBooksRoute()).then(onGoBack),
      // user reviews page
      () => context.router.push(const UserReviewRoute())..then(onGoBack),
      // user quotes page
      () => context.router.push(const UserQuotesRoute()).then(onGoBack),
      // user collections page
      () => context.router.push(const UserCollectionsRoute()).then(onGoBack),
      // user events page
      () => context.router.push(const EventsRoute()).then(onGoBack),
      // user achievements page
      //() => {},
      // user stat page
      //() => {}
    ];
    List extraRoutes = [
      // settings page
      // () => context.router.push(const SettingsRoute()).then(onGoBack),
      // about page
      () => showDialog(
          context: context,
          builder: (BuildContext context) => const AboutAppDialog()),
      // log out page
      () => context.router.navigate(const LogInRoute())
    ];

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(15),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileHead(user: user),
          StatisticRow(
            userStat: user.getStatistics(),
            routes: [mainRoutes[0], mainRoutes[1], mainRoutes[2]],
          ),
          MenuTop10Card(
            press: () => context.router.push(const Top10Route()).then(onGoBack),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Text('Общее'.toUpperCase(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Menu(titles: mainUserMenu, routes: mainRoutes),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Text('дополнительно'.toUpperCase(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Menu(titles: extraUserMenu, routes: extraRoutes),
        ],
      ),
    );
  }
}
