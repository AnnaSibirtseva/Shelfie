import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../components/constants.dart';
import '../../../../models/club_event.dart';
import '../../../../models/inherited_id.dart';
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

  Widget buildInteractionsTabBar(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;

    // return FutureBuilder<List<dynamic>>(
    //   future: Future.wait([
    //     // getClubFutureEvents(inheritedWidget.id),
    //     //getClubPastEvents(inheritedWidget.id)
    //   ]),
    //   builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    //     if (snapshot.hasData) {
    //       var futureEvents = snapshot.data![0];
    //       var pastEvents = snapshot.data![1];
    return Flexible(
      child: Container(
        height: size.height * 0.9,
        width: size.width,
        padding: EdgeInsets.only(
            top: 15, left: 15, right: 15, bottom: size.height * 0.1),
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
                      Tab(text: 'Прошедшие  ' /*quotesList.count.toString()*/)
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
                                  // for (int i = 1;
                                  //     i < futureEvents.length;
                                  //     ++i)
                                  //   ClubFutureEventCard(
                                  //     event: futureEvents[i]
                                  //         as BookClubEvent,
                                  //     clubId: club.getId(),
                                  //     notifyParent: refresh,
                                  //   ),
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
                                  UserPastEventCard(
                                    event: BookClubEvent(
                                        16,
                                        "buga wuga",
                                        "no book place",
                                        "https://im.wampi.ru/2023/03/26/emptybook.png",
                                        null,
                                        DateTime.now().toIso8601String(),
                                        0,
                                        null,
                                        false,
                                        true,
                                        "Passed",
                                        "NotSet"),
                                  )
                                  // for (int i = 0;
                                  //     i < pastEvents.length;
                                  //     ++i)
                                  //   ClubPastEventCard(
                                  //     event: pastEvents[i]
                                  //         as BookClubEvent,
                                  //   ),
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
    // } else if (snapshot.hasError) {
    //   return const Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 10),
    //     child: Text(
    //       "Не удалось получить события пользователя",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //           fontSize: 14.0,
    //           fontWeight: FontWeight.w900,
    //           color: primaryColor),
    //     ),
    //   );
    // } else {
    //   // By default, show a loading spinner.
    //   return const Center(
    //       child: CircularProgressIndicator(color: primaryColor));
    // }
    //}
    //);
  }
}
