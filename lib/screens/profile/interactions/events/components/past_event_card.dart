import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie_diploma_app/models/enums/event_status.dart';
import 'package:text_scroll/text_scroll.dart';
import 'dart:convert';

import '../../../../../components/constants.dart';
import '../../../../../components/image_constants.dart';
import '../../../../../components/routes/route.gr.dart';
import '../../../../../components/widgets/dialogs/add_event_review_dialog.dart';
import '../../../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../../../models/club_event.dart';
import '../../../../../models/enums/user_event_status.dart';
import '../../../../../models/inherited_id.dart';
import '../../../../../models/parser.dart';

class UserPastEventCard extends StatefulWidget {
  final BookClubEvent event;
  final Function() notifyParent;

  const UserPastEventCard({
    Key? key,
    required this.event,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<UserPastEventCard> createState() => _UserPastEventCard();
}

class _UserPastEventCard extends State<UserPastEventCard> {
  late int id;
  late String selectedItem =
      getStringStatForUi(widget.event.getUserParticipationStatus());

  late BookClubEvent event = widget.event;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
        height: size.height * 0.35,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: secondaryColor, width: 3),
        ),
        child: Column(
          children: [
            Container(
                height: size.height * 0.06,
                width: size.width,
                padding:
                    EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: secondaryColor),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: size.height * 0.05,
                    width: size.height * 0.05,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(defaultCollectionImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(event.getClubImg()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextScroll(event.getClubName(),
                        intervalSpaces: 5,
                        velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                        fadedBorder: true,
                        fadeBorderVisibility: FadeBorderVisibility.auto,
                        fadeBorderSide: FadeBorderSide.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height / 45)),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.star_rounded,
                    color: primaryColor,
                    size: 21,
                  ),
                  const SizedBox(width: 5),
                  Text(
                      event.getRating() == null
                          ? "-"
                          : event.getRating()!.toStringAsFixed(2),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: size.width * 0.035))
                ])),
            Expanded(
              child: Container(
                width: size.width,
                color: secondaryColor,
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.28,
                      margin:
                          const EdgeInsets.only(left: 15, bottom: 10, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: NetworkImage(defaultBookCoverImg),
                          fit: BoxFit.cover,
                        ),
                      ),
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(event.getCoverImageUrl()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: TextScroll(event.getTitle(),
                                      intervalSpaces: 5,
                                      velocity: const Velocity(
                                          pixelsPerSecond: Offset(50, 0)),
                                      fadedBorder: true,
                                      fadeBorderVisibility:
                                          FadeBorderVisibility.auto,
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
                                eventPropText(
                                    "Место: ", size, event.getPlace(), 3),
                                const SizedBox(height: 10),
                                eventPropText("Время: ", size,
                                    getStringFromDate(event.getDate()), 1),
                                const SizedBox(height: 10),
                                eventPropText(
                                    "Участники: ",
                                    size,
                                    event.getParticipantsAmount().toString(),
                                    1),
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
              ),
            ),
            Container(
              height: size.height * 0.06,
              width: size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: secondaryColor),
              child: GestureDetector(
                onTap: () => event.getHasUserEventReview()
                    ? {}
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddEventReviewDialog(
                              event: event,
                              userId: id,
                              notifyParent: widget.notifyParent);
                        }),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                        color: event.getHasUserEventReview()
                            ? secondaryColor
                            : primaryColor),
                    child: Center(
                      child: Text(
                        event.getHasUserEventReview() ? "Оценено" : "Оценить",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: event.getHasUserEventReview()
                                ? primaryColor
                                : whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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

  Widget builEventStatWidget(BuildContext context, BookClubEvent event) {
    Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Container(
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: event.getEventStatus() == EventStatus.Canceled
                ? brightRedColor
                : greenColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: EdgeInsets.all(3),
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
