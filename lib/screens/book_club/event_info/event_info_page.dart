import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../components/constants.dart';
import '../../../components/image_constants.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/dialogs/confirmation_dialog.dart';
import '../../../components/widgets/dialogs/edit_event_dialog.dart';
import '../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../components/widgets/error.dart';
import '../../../components/widgets/loading.dart';
import '../../../models/club_event.dart';
import '../../../models/comment.dart';
import '../../../models/enums/event_status.dart';
import '../../../models/enums/user_event_status.dart';
import '../../../models/inherited_id.dart';
import '../../../models/parser.dart';
import '../../../models/server_exception.dart';
import 'comment_card.dart';

class EventInfoPage extends StatefulWidget {
  final int eventId;
  final int clubId;
  final bool isUserInClub;

  const EventInfoPage(
      {Key? key,
      required this.eventId,
      required this.clubId,
      required this.isUserInClub})
      : super(key: key);

  @override
  State<EventInfoPage> createState() => _EventInfoPage();
}

class _EventInfoPage extends State<EventInfoPage> {
  late int id;
  late String selectedItem;
  late BookClubEvent event;

  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
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
          Uri.https(url, '/events/comment/${widget.eventId}/get-comments'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          });
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map((e) => Comment.fromJson(e))
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

  Future<void> createComment() async {
    var client = http.Client();
    final jsonString = json.encode({
      "text": commentController.text,
    });
    try {
      var response = await client.post(
          Uri.https(url, '/events/comment/${widget.eventId}/add'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString(),
          },
          body: jsonString);
      var msg = 'Что-то пошло не так!\n Не удалось добавить комментарий.';
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

    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: Future.wait([getEvent(widget.eventId), getEventComments(id)]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            event = snapshot.data![0];
            var comments = snapshot.data![1];
            selectedItem =
                getStringStatForUi(event.getUserParticipationStatus());
            return Container(
                margin: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 5),
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                            reverse: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                eventCardWithDesc(size),
                                const SizedBox(height: 10),
                                Text(" Комментарии",
                                    style: TextStyle(
                                        color: darkGrayColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: size.width * 0.045)),
                                const SizedBox(height: 10),
                                for (int i = 0; i < comments.length; ++i)
                                  CommentCard(comment: comments[i] as Comment),
                                const SizedBox(height: 10),
                              ],
                            ))),
                    if (widget.isUserInClub)
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: TextField(
                                  maxLines: 1,
                                  controller: commentController,
                                  cursorColor: primaryColor,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 20.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    hintText: ' Написать комментарий...',
                                    hintStyle: TextStyle(
                                        color: grayColor, fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (commentController.text.trim().isNotEmpty) {
                                  await createComment();
                                  setState(() {
                                    commentController.text = "";
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(15),
                                  backgroundColor: primaryColor),
                              child: const Icon(Icons.send_rounded,
                                  size: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                  ],
                ));
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
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Описание",
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.w900,
                        fontSize: size.width * 0.042)),
                Text(event.getDesc() == null ? "-" : event.getDesc()!,
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.035)),
              ],
            ),
          ),
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
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
              if (event.getCanBeEditedByUser() &&
                  event.getEventStatus() == EventStatus.Featured)
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
                      child: PopupMenuButton(
                          onSelected: (value) {
                            switch (value) {
                              case 'edit':
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        EditEventDialog(
                                          id: id,
                                          event: event,
                                          clubId: widget.clubId,
                                        ));
                              case 'cancel':
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        YesNoConfirmationDialog(
                                          text:
                                              'Вы дейстивтельно хотите отменить встречу "${event.getTitle()}"?',
                                          press: () async {
                                            await cancelEvent(context);
                                            context.router.pop(true);
                                            setState(() {});
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
                              borderRadius: BorderRadius.circular(15)),
                          itemBuilder: (BuildContext bc) {
                            return const [
                              PopupMenuItem(
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
                              PopupMenuItem(
                                value: 'cancel',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.do_not_disturb_rounded,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Отменить")
                                  ],
                                ),
                              ),
                            ];
                          })),
                ),
              if (event.getEventStatus() != EventStatus.Featured)
                InkWell(
                  onTap: () => event.getCanBeEditedByUser() ? {} : {},
                  child: Container(
                    width: size.width * 0.2,
                    height: size.width * 0.1,
                    padding: EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: secondaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                      ],
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
                      if (widget.isUserInClub &&
                          event.getEventStatus() == EventStatus.Featured)
                        buildDropDown(context, event),
                      if (widget.isUserInClub &&
                          event.getEventStatus() != EventStatus.Featured)
                        buildDropDownStateless(context, event),
                      if (widget.isUserInClub &&
                          event.getEventStatus() != EventStatus.Featured)
                        const SizedBox(height: 10),
                      if (widget.isUserInClub &&
                          event.getEventStatus() != EventStatus.Featured)
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

  Future<void> cancelEvent(BuildContext context) async {
    var client = http.Client();
    try {
      var response =
          await client.put(Uri.https(url, '/events/admin/cancel'), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'adminId': id.toString(),
        'eventId': event.getId().toString()
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
              onChanged: widget.isUserInClub
                  ? (newValue) async {
                      selectedItem = newValue!;
                      await changeStatus(selectedItem, event.getId());
                      await getEvent(event.getId());
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

  Widget buildDropDownStateless(BuildContext context, BookClubEvent event) {
    Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Container(
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: grayColor, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: EdgeInsets.all(2),
          child: Center(
            child: Text(getStringStatForUi(event.getUserParticipationStatus()),
                style: TextStyle(
                    color: darkGrayColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.035)),
          )),
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
