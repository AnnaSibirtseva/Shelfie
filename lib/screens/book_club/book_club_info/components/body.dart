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
import '../../../../models/inherited_id.dart';
import '../../components/club_name_widget.dart';
import 'drop_down_menu.dart';

class BookClubBody extends StatefulWidget {
  final int clubId;

  const BookClubBody({Key? key, required this.clubId}) : super(key: key);

  @override
  _BookClubBody createState() => _BookClubBody();
}

class _BookClubBody extends State<BookClubBody> {
  late int id;

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
              height: size.height * 1,
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
                    isAdmin: true,
                  ),
                  const SizedBox(height: 10),
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
}
