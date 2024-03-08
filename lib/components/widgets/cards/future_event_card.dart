import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/club_event.dart';
import '../../../models/enums/user_event_status.dart';
import '../../../models/inherited_id.dart';
import '../../../models/parser.dart';
import '../../../models/user_collection.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../dialogs/nothing_found_dialog.dart';
import '../error.dart';

class FutureEventCard extends StatefulWidget {
  final int clubId;

  const FutureEventCard({
    Key? key,
    required this.clubId,
  }) : super(key: key);

  @override
  State<FutureEventCard> createState() => _AddCollectionCardState();
}

class _AddCollectionCardState extends State<FutureEventCard> {
  late int id;
  late String selectedItem;

  @override
  void initState() {
    super.initState();
  }

  Future<BookClubEvent> getClubEvent(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/clubs/detailed/${widget.clubId}/event/nearest'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          });
      if (response.statusCode == 200) {
        return BookClubEvent.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
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

    return FutureBuilder<BookClubEvent>(
        future: getClubEvent(inheritedWidget.id),
        builder: (BuildContext context, AsyncSnapshot<BookClubEvent> snapshot) {
          if (snapshot.hasData) {
            BookClubEvent event = snapshot.data!;
            selectedItem =
                getStringStatForUi(event.getUserParticipationStatus());
            return InkWell(
              child: Container(
                margin: const EdgeInsets.only(right: 5, top: 5),
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
                                        image: NetworkImage(
                                            event.getCoverImageUrl()),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: RichText(
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                  text: event.getTitle(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: blackColor,
                                                      fontSize:
                                                          size.width * 0.045))),
                                        ),
                                        const SizedBox(height: 10),
                                        eventPropNameText(
                                            "Книгa: ",
                                            size,
                                            (event.getBookInfo() == null)
                                                ? "-"
                                                : '"${event.getBookInfo()!.getTitle()}"',
                                            event.getBookInfo() != null),
                                        const SizedBox(height: 10),
                                        eventPropText("Место: ", size,
                                            event.getPlace(), 3),
                                        const SizedBox(height: 10),
                                        eventPropText(
                                            "Время: ",
                                            size,
                                            getStringFromDate(event.getDate()),
                                            1),
                                        const SizedBox(height: 10),
                                        eventPropText(
                                            "Участники: ",
                                            size,
                                            event
                                                .getParticipantsAmount()
                                                .toString(),
                                            1),
                                        const SizedBox(height: 10),
                                        buildDropDown(
                                          context,
                                          event.getId(),
                                        )
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
          } else if (snapshot.hasError) {
            String message =
                "Не удалось получить информацию по ближайшему событию";
            if (snapshot.error != null) {
              message = "Нет ближайших событий";
            }
            return WebErrorWidget(size: 150, errorMessage: message);
          } else {
            // By default, show a loading spinner.
            return const Center(
                child: CircularProgressIndicator(color: primaryColor));
          }
        });
  }

  Widget eventPropNameText(String name, Size size, String text, bool selected) {
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

  Widget buildDropDown(BuildContext context, int eventId) {
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
                await changeStatus(selectedItem, eventId);
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