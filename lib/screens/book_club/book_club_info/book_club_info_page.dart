import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../components/constants.dart';
import '../../../components/widgets/error.dart';
import '../../../components/widgets/loading.dart';
import '../../../models/book_club.dart';
import '../../../models/inherited_id.dart';
import 'package:http/http.dart' as http;

import 'components/book_club_head.dart';
import 'components/body.dart';

class BookClubInfoPage extends StatefulWidget {
  final int bookClubId;

  const BookClubInfoPage(this.bookClubId, {Key? key}) : super(key: key);

  @override
  State<BookClubInfoPage> createState() => _BookClubInfoPage();
}

class _BookClubInfoPage extends State<BookClubInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<BookClub> getBookClubInfo(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.http(url, '/clubs/detailed/${widget.bookClubId}/info'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'userId': id.toString()
        },
      ).timeout(const Duration(seconds: 15));
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
    final inheritedWidget = IdInheritedWidget.of(context);
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<BookClub>(
        future: getBookClubInfo(inheritedWidget.id),
        builder: (BuildContext context, AsyncSnapshot<BookClub> snapshot) {
          if (snapshot.hasData) {
            BookClub bookClub = snapshot.data!;
            return Container(
                margin: EdgeInsets.only(bottom: 0),
                height: size.height * 1,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BookClubHead(bookClub: bookClub),
                        BookClubBody(
                          clubId: bookClub.getId(),
                        ),
                      ]),
                ));
          } else if (snapshot.hasError) {
            return const WebErrorWidget(errorMessage: noInternetErrorMessage);
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }
}
