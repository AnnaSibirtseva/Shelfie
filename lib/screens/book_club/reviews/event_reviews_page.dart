import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../components/constants.dart';
import '../../../../models/inherited_id.dart';
import '../../../components/image_constants.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/error.dart';
import '../../../components/widgets/loading.dart';
import '../../../models/club_event.dart';
import '../../../models/enums/event_status.dart';
import '../../../models/event_review.dart';
import '../../../models/parser.dart';
import '../../../models/server_exception.dart';
import 'event_review_card.dart';

class EventReviewsPage extends StatefulWidget {
  final int eventId;

  const EventReviewsPage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventReviewsPage> createState() => _EventReviewsPage();
}

class _EventReviewsPage extends State<EventReviewsPage>
    with SingleTickerProviderStateMixin {
  late int id;
  late BookClubEvent event;

  @override
  void initState() {
    super.initState();
  }

  Future<BookClubEvent> getEvent(int eventId) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/clubs/detailed/event/${eventId.toString()}'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString(),
          });
      if (response.statusCode == 200) {
        return BookClubEvent.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception("Не удалось получить информаю о событии");
      }
    } finally {
      client.close();
    }
  }

  Future<List<dynamic>> getEventComments(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/events/review/${widget.eventId}/get-reviews'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'adminId': id.toString()
          });
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => EventReview.fromJson(e))
            .toList();
      }
      if (errorWithMsg.contains(response.statusCode)) {
        var ex = ServerException.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
        throw Exception(ex.getMessage());
      } else {
        throw Exception("Не удалось получить информацию о событии");
      }
    } finally {
      client.close();
    }
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: Future.wait([getEvent(widget.eventId), getEventComments(id)]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            event = snapshot.data![0];
            var comments = snapshot.data![1];
            return Container(
                margin: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 5),
                height: size.height,
                width: size.width,
                child: Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                          reverse: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              eventCardWithDesc(size),
                              const SizedBox(height: 10),
                              Text(" Отзывы",
                                  style: TextStyle(
                                      color: darkGrayColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: size.width * 0.045)),
                              const SizedBox(height: 10),
                              for (int i = 0; i < comments.length; ++i)
                                EventReviewCard(
                                  review: comments[i] as EventReview,
                                  notifyParent: refresh,
                                ),
                              const SizedBox(height: 10),
                            ],
                          ))),
                ]));
          } else if (snapshot.hasError) {
            return WebErrorWidget(
                errorMessage:
                    snapshot.error.toString().replaceAll("Exception:", ""));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        },
      )),
    );
  }

  Widget eventCardWithDesc(Size size) {
    return Container(
      //height: size.height * 0.45,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: secondaryColor, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: [
          eventCard(size),
        ],
      ),
    );
  }

  Widget eventCard(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.33,
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: size.width * 0.33,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(defaultBookCoverImg),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(event.getCoverImageUrl()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextScroll(event.getTitle(),
                            intervalSpaces: 5,
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(50, 0)),
                            fadedBorder: true,
                            fadeBorderVisibility: FadeBorderVisibility.auto,
                            fadeBorderSide: FadeBorderSide.right,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: blackColor,
                                fontSize: size.width * 0.045)),
                      ),
                      const SizedBox(height: 10),
                      eventPropNameText(
                          "Книгa: ",
                          size,
                          (event.getBookInfo() == null)
                              ? "Не выбрана"
                              : '"${event.getBookInfo()!.getTitle()}"',
                          event.getBookInfo() != null,
                          (event.getBookInfo() == null)
                              ? 0
                              : event.getBookInfo()!.getId()),
                      const SizedBox(height: 10),
                      eventPropText("Место: ", size, event.getPlace(), 3),
                      const SizedBox(height: 10),
                      eventPropText("Время: ", size,
                          getStringFromDate(event.getDate()), 1),
                      const SizedBox(height: 10),
                      eventPropText("Участники: ", size,
                          event.getParticipantsAmount().toString(), 1),
                      const SizedBox(height: 10),
                      builEventStatWidget(context, event),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget eventPropText(String name, Size size, String text, int maxLines) {
    return Flexible(
        child: RichText(
            softWrap: false,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: name,
              style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.035),
              children: <TextSpan>[
                TextSpan(
                    text: text,
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.035)),
              ],
            )));
  }

  Widget eventPropNameText(
      String name, Size size, String text, bool selected, int id) {
    return Flexible(
      child: InkWell(
          onTap: () =>
              selected ? (context.router.push(BookInfoRoute(bookId: id))) : {},
          child: RichText(
              softWrap: false,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: name,
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.035),
                children: <TextSpan>[
                  TextSpan(
                      text: text,
                      style: TextStyle(
                          color: selected ? primaryColor : grayColor,
                          decoration: selected
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.035)),
                ],
              ))),
    );
  }

  Widget builEventStatWidget(BuildContext context, BookClubEvent event) {
    Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Container(
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: event.getEventStatus() == EventStatus.Canceled
                ? brightRedColor
                : greenColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.all(3),
          child: Center(
            child: Text(getStringEventStatForUi(event.getEventStatus()),
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.035)),
          )),
    );
  }
}
