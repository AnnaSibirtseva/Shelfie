import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../components/constants.dart';
import '../../../../components/widgets/error.dart';
import '../../../../components/widgets/loading.dart';
import '../../../../models/achivment.dart';
import '../../../../models/inherited_id.dart';
import 'achievement_card.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  @override
  State<AchievementsPage> createState() => _AchievementsPage();
}

class _AchievementsPage extends State<AchievementsPage> {
  late int id;

  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> getAchievements(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/support-achievement/get-info'),
          headers: {'userId': id.toString()});
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => Achievement.fromJson(e))
            .toList();
      } else {
        throw Exception(
            'Не удалось получить информацию о достижениях пользователя.');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<dynamic>>(
        future: Future.wait([getAchievements(inheritedWidget.id)]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                    reverse: false,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 5,),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: size.height * 0.09,
                                width: size.width * 0.09,
                                child:
                                    //Image.network('https://disk.yandex.ru/i/i8FVLoIZxIl8xQ')
                                    Image.asset('assets/images/achieve.png'),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                'Достижения',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'VelaSansExtraBold',
                                    //color: Colors.black,
                                    fontSize: size.width / 12,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          for (int i = 0; i < snapshot.data![0].length; ++i)
                            AchievementCard(
                              achievement: snapshot.data![0][i] as Achievement,
                            ),
                        ],
                      ),
                    )),
              ),
            );
          } else if (snapshot.hasError) {
            return SizedBox(
              height: size.height * 0.8,
              width: size.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WebErrorWidget(
                      errorMessage: "Не удалось получить события пользователя"),
                ],
              ),
            );
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }
}
