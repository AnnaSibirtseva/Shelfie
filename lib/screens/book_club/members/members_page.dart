import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../components/constants.dart';
import '../../../../models/inherited_id.dart';
import '../../../components/custon_switch.dart';
import '../../../components/image_constants.dart';
import '../../../components/widgets/custom_icons.dart';
import '../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../components/widgets/nothing_found.dart';
import '../../../models/club_member.dart';
import '../../../models/club_requests.dart';
import '../../../models/server_exception.dart';
import 'components/member_card.dart';
import 'components/request_card.dart';

class ClubMembersPage extends StatefulWidget {
  final int clubId;

  const ClubMembersPage({Key? key, required this.clubId}) : super(key: key);

  @override
  State<ClubMembersPage> createState() => _ClubMembersPage();
}

class _ClubMembersPage extends State<ClubMembersPage>
    with SingleTickerProviderStateMixin {
  late int id;
  late TabController _tabController;

  bool _value = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  Future<List<dynamic>> getClubRequestList(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(
            url,
            '/clubs/admin/${widget.clubId}/requests',
          ),
          headers: {'adminId': id.toString()});
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => ClubRequest.fromJson(e))
            .toList();
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<List<dynamic>> getClubMemberList(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(
            url,
            '/clubs/admin/${widget.clubId}/members',
          ),
          headers: {'adminId': id.toString()});
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => ClubMember.fromJson(e))
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
                children: <Widget>[
                  buildInteractionsTabBar(context),
                ])),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  refresh() {
    setState(() {});
  }

  Widget buildInteractionsTabBar(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<dynamic>>(
        future: Future.wait([
          getClubRequestList(inheritedWidget.id),
          getClubMemberList(inheritedWidget.id)
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var requestList = snapshot.data![0];
            var memberList = snapshot.data![1];
            return Flexible(
              child: Container(
                height: size.height * 0.9,
                width: size.width,
                padding: EdgeInsets.only(
                    top: 15, left: 15, right: 15),
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
                                      'Участнкии  ' /*reviewList.count.toString()*/),
                              Tab(
                                  text:
                                      'Заявки  ' /*quotesList.count.toString()*/)
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
                                          if (memberList.isNotEmpty)
                                            MemberCard(
                                              notifyParent: refresh,
                                              member:
                                                  memberList[0] as ClubMember,
                                              showSwitch: false,
                                              roleText: 'Создатель',
                                              clubId: widget.clubId,
                                            ),
                                          if (memberList.isNotEmpty)
                                            const Divider(
                                              color: secondaryColor,
                                              thickness: 2,
                                            ),
                                          for (int i = 1;
                                              i < memberList.length;
                                              ++i)
                                            MemberCard(
                                              notifyParent: refresh,
                                              member:
                                                  memberList[i] as ClubMember,
                                              showSwitch:
                                                  memberList[i].getId() != id,
                                              roleText:
                                                  memberList[i].getId() == id
                                                      ? 'Вы'
                                                      : '',
                                              clubId: widget.clubId,
                                            )

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
                                          if (requestList.isEmpty)
                                            const NothingFoundWidget(
                                              image: noTop10,
                                              message:
                                                  "Нет необработанных заявок",
                                              space: true,
                                            ),
                                          if (requestList.isNotEmpty)
                                            for (int i = 0;
                                                i < requestList.length;
                                                ++i)
                                              MembershipRequestCard(
                                                notifyParent: refresh,
                                                request: requestList[i]
                                                    as ClubRequest,
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
                    const SizedBox(height: 5,)
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Не удалось получить события пользователя",
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
