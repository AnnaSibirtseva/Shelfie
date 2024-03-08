import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../components/constants.dart';
import '../../../../components/image_constants.dart';
import '../../../../components/routes/route.gr.dart';
import '../../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../../models/club_event.dart';
import '../../../../models/enums/user_event_status.dart';
import '../../../../models/inherited_id.dart';
import '../../../../models/parser.dart';

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
                                  child: RichText(
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          text: event.getTitle(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: blackColor,
                                              fontSize: size.width * 0.045))),
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
                                buildDropDown(context, event)
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

  Future<void> changeStatus(String status, int eventId) async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.https(url, '/events/member/participate'), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'userId': id.toString(),
        'eventId': eventId.toString(),
        'status': getStringStatForApi(selectedItem).name
      });
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) => const Center(
                child: NothingFoundDialog(
                    'Что-то пошло не так!\nСтатус не был изменен.',
                    warningGif,
                    'Ошибка')));
      }
    } finally {
      client.close();
    }
  }

  Future<void> getEvent(int eventId) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/clubs/detailed/event/${eventId.toString()}'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString(),
          });
      if (response.statusCode == 200) {
        event =
            BookClubEvent.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => const Center(
                child: NothingFoundDialog(
                    'Не удалось обновить информацию о событии',
                    warningGif,
                    'Ошибка')));
      }
    } finally {
      client.close();
    }
  }

  Widget buildDropDown(BuildContext context, BookClubEvent event) {
    Size size = MediaQuery.of(context).size;

    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return Flexible(
      child: Container(
        width: size.width * 0.5,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.only(
          left: size.width * 0.1,
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isDense: true,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              dropdownColor: primaryColor,
              value: selectedItem,
              style: TextStyle(fontWeight: FontWeight.bold),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: whiteColor,
              ),
              onChanged: (newValue) async {
                selectedItem = newValue!;
                await changeStatus(selectedItem, event.getId());
                await getEvent(event.getId());
                setState(() {});
              },
              items:
                  eventAttendance.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
