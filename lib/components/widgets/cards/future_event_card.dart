import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/club_event.dart';
import '../../../models/enums/user_event_status.dart';
import '../../../models/inherited_id.dart';
import '../../../models/parser.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../routes/route.gr.dart';
import '../dialogs/confirmation_dialog.dart';
import '../dialogs/edit_event_dialog.dart';
import '../dialogs/nothing_found_dialog.dart';
import '../error.dart';

class FutureEventCard extends StatefulWidget {
  final Function() notifyParent;
  final int clubId;
  final bool isUserInCLub;

  const FutureEventCard({
    Key? key,
    required this.clubId,
    required this.notifyParent,
    required this.isUserInCLub,
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

  Future<void> deleteEvent(BuildContext context, int eventId) async {
    var client = http.Client();
    try {
      var response =
          await client.delete(Uri.https(url, '/events/admin/delete'), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'adminId': id.toString(),
        'eventId': eventId.toString()
      });
      var msg = 'Что-то пошло не так!\n Не удалось удалить событие.';
      if (response.statusCode != 200) {
        if ([400, 404, 403].contains(response.statusCode)) {
          msg = response.toString();
        }
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                Center(child: NothingFoundDialog(msg, warningGif, 'Ошибка')));
      }
    } finally {
      client.close();
    }
  }

  Future<void> cancelEvent(BuildContext context, int eventId) async {
    var client = http.Client();
    try {
      var response =
          await client.put(Uri.https(url, '/events/admin/cancel'), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'adminId': id.toString(),
        'eventId': eventId.toString()
      });
      var msg = 'Что-то пошло не так!\n Не удалось отменить событие.';
      if (response.statusCode != 200) {
        if ([400, 404, 403].contains(response.statusCode)) {
          msg = response.toString();
        }
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                Center(child: NothingFoundDialog(msg, warningGif, 'Ошибка')));
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
            bool disableDelete = event.getParticipantsAmount() != 0;

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
                                                bottomRight:
                                                    Radius.circular(15)),
                                            color: secondaryColor),
                                        child: PopupMenuButton(
                                            onSelected: (value) {
                                              switch (value) {
                                                case 'delete':
                                                  if (!disableDelete) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            ConfirmationDialog(
                                                              text:
                                                                  'Вы дейстивтельно хотите удалить встречу "${event.getTitle()}"?',
                                                              press: () async {
                                                                await deleteEvent(
                                                                    context,
                                                                    event
                                                                        .getId());
                                                                context.router
                                                                    .pop(true);
                                                                widget
                                                                    .notifyParent();
                                                              },
                                                            ));
                                                  } else {
                                                    Flushbar(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      backgroundColor: redColor,
                                                      messageText: const Text(
                                                        "Нельзя удалить встречу, на которой есть участники",
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      icon: const Icon(
                                                        Icons.info_outline,
                                                        size: 28.0,
                                                        color: whiteColor,
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 3),
                                                    ).show(context);
                                                  }
                                                case 'edit':
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          EditEventDialog(
                                                            id: inheritedWidget
                                                                .id,
                                                            event: event,
                                                            clubId:
                                                                widget.clubId,
                                                          ));
                                                case 'cancel':
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          YesNoConfirmationDialog(
                                                            text:
                                                                'Вы дейстивтельно хотите отменить встречу "${event.getTitle()}"?',
                                                            press: () async {
                                                              await cancelEvent(
                                                                  context,
                                                                  event
                                                                      .getId());
                                                              context.router
                                                                  .pop(true);
                                                              widget
                                                                  .notifyParent();
                                                            },
                                                          ));
                                              }
                                            },
                                            icon: Icon(
                                              Icons.adaptive.more,
                                              color: primaryColor,
                                            ),
                                            color: secondaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            itemBuilder: (BuildContext bc) {
                                              return [
                                                const PopupMenuItem(
                                                  value: 'edit',
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.mode_edit_rounded,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Редактировать")
                                                    ],
                                                  ),
                                                ),
                                                const PopupMenuItem(
                                                  value: 'cancel',
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .do_not_disturb_rounded,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Отменить")
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 'delete',
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.delete_rounded,
                                                        color: disableDelete
                                                            ? grayColor
                                                            : brightRedColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Удалить",
                                                          style: TextStyle(
                                                            color: disableDelete
                                                                ? grayColor
                                                                : brightRedColor,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ];
                                            })),
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
                                                ? "Не выбрана"
                                                : '"${event.getBookInfo()!.getTitle()}"',
                                            event.getBookInfo() != null,
                                            (event.getBookInfo() == null)
                                                ? 0
                                                : event.getBookInfo()!.getId()),
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
                                        if (widget.isUserInCLub)
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
                    GestureDetector(
                      onTap: () => context.router.push(EventInfoRoute(
                          eventId: event.getId(),
                          clubId: widget.clubId,
                          isUserInClub: widget.isUserInCLub)),
                      child: Container(
                        height: size.height * 0.05,
                        width: size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            color: secondaryColor),
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
            return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).scaffoldBackgroundColor));
          }
        });
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

  Widget buildDropDown(BuildContext context, int eventId) {
    Size size = MediaQuery.of(context).size;

    bool canChange = widget.isUserInCLub;

    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return Flexible(
      child: Container(
        width: size.width * 0.5,
        decoration: BoxDecoration(
          color: canChange ? primaryColor : lightGrayColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
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
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: canChange ? whiteColor : darkGrayColor,
              ),
              onChanged: canChange
                  ? (newValue) async {
                      selectedItem = newValue!;
                      await changeStatus(selectedItem, eventId);
                      setState(() {});
                    }
                  : null,
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
