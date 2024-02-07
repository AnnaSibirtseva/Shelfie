import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../components/constants.dart';
import '../../../../models/club_event.dart';
import '../../../../models/inherited_id.dart';
import 'drop_down_menu.dart';

class ClubFutureEventCard extends StatefulWidget {
  final BookClubEvent event;

  const ClubFutureEventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<ClubFutureEventCard> createState() => _AddCollectionCardState();
}

class _AddCollectionCardState extends State<ClubFutureEventCard> {
  late int id;

  get event => widget.event;

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
        margin: const EdgeInsets.only(right: 5, top: 5, bottom: 10),
        height: size.height * 0.35,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: secondaryColor, width: 3),
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: size.width,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15)),
                              image: DecorationImage(
                                image: NetworkImage(event.getCoverImageUrl()),
                                fit: BoxFit.cover,
                              ),
                            )),
                        if (event.getCanBeEditedByUser())
                          InkWell(
                            onTap: () => {},
                            child: Container(
                              width: size.width * 0.1,
                              height: size.width * 0.1,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  color: secondaryColor),
                              child: const Icon(
                                Icons.mode_edit_rounded,
                                color: primaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                      event
                                          .getTitle()
                                          .replaceAll("", "\u{200B}"),
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: size.width * 0.045)),
                                ),
                                const SizedBox(height: 10),
                                eventPropNameText("Книгa: ", size,
                                    '"${event.getBookInfo().getTitle()}"'),
                                const SizedBox(height: 10),
                                eventPropText(
                                    "Место: ", size, event.getPlace(), 3),
                                const SizedBox(height: 10),
                                eventPropText("Время: ", size, "04.07.2024", 1),
                                const SizedBox(height: 10),
                                eventPropText(
                                    "Участники: ",
                                    size,
                                    event.getParticipantsAmount().toString(),
                                    1),
                                const SizedBox(height: 10),
                                DropDownMenu()
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
              height: size.height * 0.05,
              width: size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: secondaryColor),
              child: GestureDetector(
                onTap: () => {},
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Комментарии",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: darkGrayColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget eventPropNameText(String name, Size size, String text) {
    return Flexible(
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
                  fontSize: size.width * 0.036),
              children: <TextSpan>[
                TextSpan(
                    text: text,
                    style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.04)),
              ],
            )));
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
                  fontSize: size.width * 0.038),
              children: <TextSpan>[
                TextSpan(
                    text: text,
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.04)),
              ],
            )));
  }
}
