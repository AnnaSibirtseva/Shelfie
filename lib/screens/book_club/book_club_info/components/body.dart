import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../components/constants.dart';
import '../../../../components/image_constants.dart';
import '../../../../components/widgets/cards/future_event_card.dart';
import '../../../../components/widgets/error.dart';
import '../../../../components/widgets/loading.dart';
import '../../../../models/book_club.dart';
import '../../../../models/club_event.dart';
import '../../../../models/inherited_id.dart';
import '../../components/club_name_widget.dart';
import 'drop_down_menu.dart';
import 'future_event_card.dart';

class BookClubBody extends StatefulWidget {
  final int clubId;

  const BookClubBody({Key? key, required this.clubId}) : super(key: key);

  @override
  _BookClubBody createState() => _BookClubBody();
}

class _BookClubBody extends State<BookClubBody>
    with SingleTickerProviderStateMixin {
  late int id;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  Future<void> makeMemberShipRequest(int id) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.http(url, '/clubs/join'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'userId': id.toString(),
          'clubId': widget.clubId.toString()
        },
      );
      if (response.statusCode != 200) {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<BookClub> getBookClubInfo(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.http(url, '/clubs/detailed/${widget.clubId}/info'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'userId': id.toString()
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return BookClub.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception();
      }
    } on TimeoutException catch (_) {
      throw TimeoutException("Превышел лимит ожидания ответа от сервера.\n"
          "Попробуйте позже, сейчас хостинг перезагружается - это может занять какое-то время");
    } finally {
      client.close();
    }
  }

  Future<List<dynamic>> getClubEvents(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/clubs/detailed/${widget.clubId}/event/featured'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          });
      if (response.statusCode == 200) {
        var a = jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => BookClubEvent.fromJson(e))
            .toList();
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => BookClubEvent.fromJson(e))
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
    Size size = MediaQuery.of(context).size;

    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return FutureBuilder<BookClub>(
        future: getBookClubInfo(inheritedWidget.id),
        builder: (BuildContext context, AsyncSnapshot<BookClub> snapshot) {
          if (snapshot.hasData) {
            BookClub club = snapshot.data!;
            return Flexible(
                child: Container(
              //height: size.height * 1.5,
              margin: EdgeInsets.only(left: 20, top: 5, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('ОПИСАНИЕ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  const SizedBox(height: 5),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: SingleChildScrollView(
                            child: Text(club.getDescription() ?? "-",
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        await makeMemberShipRequest(id);
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            club.isUserInClub() ? secondaryColor : primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                          club.isUserInClub()
                              ? 'Покинуть'
                              : (club.isPublic()
                                  ? 'Вступить'
                                  : 'Подать заявку'),
                          style: TextStyle(
                              color:
                                  club.isUserInClub() ? grayColor : whiteColor,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureEventCard(
                    clubId: club.getId(),
                  ),
                  const SizedBox(height: 20),
                  buildInteractionsTabBar(context)
                ],
              ),
            ));
          } else if (snapshot.hasError) {
            return const WebErrorWidget(errorMessage: noInternetErrorMessage);
          } else {
            // By default, show a loading spinner.
            return const Center(
                child: CircularProgressIndicator(color: primaryColor));
          }
        });
  }

  Widget buildInteractionsTabBar(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<dynamic>(
        future: getClubEvents(inheritedWidget.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var events = snapshot.data!;
            return Flexible(
              child: SizedBox(
                height: size.height * 0.6,
                width: size.width,
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
                                  SizedBox(
                                    width: size.width,
                                    child: ElevatedButton(
                                      onPressed: () => {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: secondaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: const Text('Добавить встречу',
                                          style: TextStyle(color: grayColor)),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: size.height * 0.9,
                                      child: SingleChildScrollView(
                                          reverse: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              for (int i = 0; i < events.length; ++i)
                                                ClubFutureEventCard(
                                                  event: events[i] as BookClubEvent,
                                                ),
                                            ],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),

                            // second tab bar view widget
                            SingleChildScrollView(
                              reverse: false,
                              child: Column(
                                children: [
                                  // for (int i = 0; i < _allClubs.length; ++i)
                                  //   SearchBookClubCard(
                                  //     press: () => (context.router.push(
                                  //         BookClubInfoRoute(bookId: _allClubs[i].getId()))),
                                  //     bookClub: _allClubs[i],
                                  //   ),
                                ],
                              ),
                            ),
                          ],

                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Не удалось получить события клуба",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w900,
                    color: primaryColor),
              ),
            );
          } else {
            // By default, show a loading spinner.
            return const Center(
                child: CircularProgressIndicator(color: primaryColor));
          }
        });
  }
}
