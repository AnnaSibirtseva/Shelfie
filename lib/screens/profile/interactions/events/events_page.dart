import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shelfie_diploma_app/components/widgets/nothing_found.dart';

import '../../../../components/constants.dart';
import '../../../../components/image_constants.dart';
import '../../../../components/routes/route.gr.dart';
import '../../../../components/widgets/error.dart';
import '../../../../models/club_event.dart';
import '../../../../models/inherited_id.dart';
import 'components/future_event_card.dart';
import 'components/past_event_card.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPage();
}

class _EventsPage extends State<EventsPage>
    with SingleTickerProviderStateMixin {
  late int id;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  Future<List<dynamic>> getUserPastEvents(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(url, '/events/member/past'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          });
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => BookClubEvent.forUserFromJson(e))
            .toList();
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<List<dynamic>> getUserFutureEvents(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(url, '/events/member/featured'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          });
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => BookClubEvent.forUserFromJson(e))
            .toList();
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            reverse: false,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[buildInteractionsTabBar(context)])),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  refresh() {
    context.router.pop();
    context.router.push(const EventsRoute());
    setState(() {});
  }

  Widget buildInteractionsTabBar(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<dynamic>>(
        future: Future.wait([
          getUserFutureEvents(inheritedWidget.id),
          getUserPastEvents(inheritedWidget.id),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var futureEvents = snapshot.data![0];
            var pastEvents = snapshot.data![1];

            return Flexible(
              child: Container(
                height: size.height * 0.9,
                width: size.width,
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TabBar(
                            // isScrollable: true,
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                              color: primaryColor,
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            unselectedLabelStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                            labelStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            tabs: const [
                              Tab(
                                  text:
                                      'Предстоящие  ' /*reviewList.count.toString()*/),
                              Tab(
                                  text:
                                      'Прошедшие  ' /*quotesList.count.toString()*/)
                            ],
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // first tab bar view widget
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: size.height * 0.9,
                                  child: SingleChildScrollView(
                                      reverse: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (futureEvents.isEmpty)
                                            const NothingFoundWidget(
                                              image: noTop10,
                                              message: "Ой!\nУ вас еще нет предстоящих встреч",
                                              space: true,
                                            ),
                                          for (int i = 0;
                                              i < futureEvents.length;
                                              ++i)
                                            UserFutureEventCard(
                                              event: futureEvents[i]
                                                  as BookClubEvent,
                                              notifyParent: refresh,
                                            ),
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),

                          // second tab bar view widget
                          Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: size.height * 0.9,
                                  child: SingleChildScrollView(
                                      reverse: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (pastEvents.isEmpty)
                                            const NothingFoundWidget(
                                              image: noTop10,
                                              message: "Ой!\nУ вас еще нет прошедших встреч",
                                              space: true,
                                            ),
                                          for (int i = 0;
                                              i < pastEvents.length;
                                              ++i)
                                            UserPastEventCard(
                                              event: pastEvents[i]
                                                  as BookClubEvent,
                                              notifyParent: refresh,
                                            ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
            return SizedBox(
                height: size.height * 0.8,
                width: size.width,
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: CircularProgressIndicator(color: primaryColor))
                    ]));
          }
        });
  }
}
