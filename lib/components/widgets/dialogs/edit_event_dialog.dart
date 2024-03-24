import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'dart:convert';
import 'dart:io';
import '../../../models/book.dart';
import '../../../models/club_event.dart';
import '../../../models/parser.dart';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../routes/route.gr.dart';
import '../../text_fields/input_text_field.dart';
import '../error.dart';
import 'nothing_found_dialog.dart';

class EditEventDialog extends Dialog {
  final int id;
  final int clubId;
  final BookClubEvent event;
  late String _name;
  late String _place;
  late String _coverImageUrl;
  late DateTime _dateTime;

  int? _bookId;
  bool _isButtonDisabled = false;

  EditEventDialog(
      {Key? key, required this.id, required this.event, required this.clubId})
      : super(key: key) {
    _name = event.getTitle();
    _place = event.getPlace();
    // todo add desc
    _coverImageUrl = event.getCoverImageUrl();
    _dateTime = convertToUtcWithOffset(event.getDate());
  }

  Future<void> editEvent(BuildContext context) async {
    var s = convertToUtcPlusZero(_dateTime).toIso8601String();
    var client = http.Client();
    final jsonString = json.encode({
      "title": _name,
      "place": _place,
      if (_coverImageUrl.trim().isNotEmpty) "coverImageUrl": _coverImageUrl,
      //"bannerImageUrl": , description
      if (_bookId != null) "bookId": _bookId,
      "date": convertToUtcPlusZero(_dateTime).toIso8601String()
    });
    try {
      var response = await client.put(Uri.https(url, '/events/admin/edit'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'adminId': id.toString(),
            'eventId': event.getId().toString()
          },
          body: jsonString);
      var msg = 'Что-то пошло не так!\n Не удалось создать событие.';
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

  Future<void> cancelEvent(BuildContext context) async {
    var client = http.Client();
    try {
      var response = await client.delete(Uri.https(url, '/events/admin/cancel'),
          headers: {
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

  Future<List<Book>> searchBooks() async {
    var client = http.Client();
    final jsonString = json.encode({"query": "", "take": 10000, "skip": 0});
    try {
      var response = await client
          .post(Uri.https(url, '/books/search/'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                'userId': id.toString()
              },
              body: jsonString)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var allBooks =
            BookList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
                .foundBooks;
        allBooks.sort((a, b) => a.getTitle().compareTo(b.getTitle()));
        return allBooks;
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Dialog build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return FutureBuilder<List<Book>>(
              future: searchBooks(),
              builder: (context, AsyncSnapshot<List<Book>> snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    reverse: false,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: size.width * 0.8,
                      height: size.height * 0.6,
                      child: SingleChildScrollView(
                        reverse: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  size: size.width / 15,
                                ),
                                const Spacer(),
                                Text('Новый ивент',
                                    style: TextStyle(
                                        fontFamily: 'VelaSansExtraBold',
                                        fontSize: size.width / 20,
                                        fontWeight: FontWeight.w800)),
                                const Spacer(),
                                Icon(
                                  Icons.settings,
                                  size: size.width / 15,
                                ),
                              ],
                            ),
                            const Divider(color: primaryColor),
                            const SizedBox(height: 10),
                            textTitle(size, 'Название'),
                            InputTextField(
                              maxLen: 50,
                              height: 0.1,
                              defaultText: _name,
                              onChanged: (String value) {
                                _name = value;
                              },
                            ),
                            textTitle(size, 'Книга'),
                            const SizedBox(height: 10),
                            CustomDropdown<Book>.search(
                                hintText: 'Выберите книгу',
                                searchHintText: "Поиск",
                                initialItem: _bookId == null
                                    ? null
                                    : snapshot.data!.firstWhere(
                                        (book) => book.getId() == _bookId),
                                noResultFoundText: "Не удалось ничего найти",
                                maxlines: 3,
                                items: snapshot.data!,
                                excludeSelected: false,
                                onChanged: (value) {
                                  _bookId = value.getId();
                                },
                                decoration: CustomDropdownDecoration(
                                    closedBorderRadius:
                                        BorderRadius.circular(15),
                                    searchFieldDecoration:
                                        SearchFieldDecoration(
                                      textStyle:
                                          const TextStyle(color: primaryColor),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: primaryColor),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: primaryColor, width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      fillColor: secondaryColor,
                                    ))),
                            const SizedBox(height: 10),
                            textTitle(size, 'Место'),
                            InputTextField(
                              maxLen: 250,
                              height: 0.2,
                              defaultText: _place,
                              onChanged: (String value) {
                                // todo change to place
                                _place = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            textTitle(size, 'Изображение'),
                            InputTextField(
                              maxLen: 0,
                              height: 0.1,
                              defaultText: _coverImageUrl == defaultBookCoverImg
                                  ? null
                                  : _coverImageUrl,
                              hintText: 'Прямая ссылка на изображение',
                              onChanged: (String value) {
                                _coverImageUrl = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            textTitle(size, 'Время'),
                            SizedBox(
                              width: size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  picker.DatePicker.showDateTimePicker(
                                    context,
                                    theme: const picker.DatePickerTheme(
                                      headerColor: secondaryColor,
                                      backgroundColor: secondaryColor,
                                      itemStyle: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                      cancelStyle: TextStyle(
                                          color: darkGrayColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    showTitleActions: true,
                                    onConfirm: (date) {
                                      setState(() {
                                        _dateTime = date;
                                      });
                                    },
                                    currentTime: _dateTime,
                                    locale: picker.LocaleType.ru,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Text(getStringFromDate(),
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DialogButton(
                                    isAsync: true,
                                    press: () {
                                      context.router.pop();
                                    },
                                    reverse: true,
                                    text: 'Отменить'),
                                const SizedBox(
                                  width: 10,
                                ),
                                DialogButton(
                                    press: _isButtonDisabled ? () => {} : () async {
                                      if (checkRestrictions(context)) {
                                        _isButtonDisabled = true;
                                        await editEvent(context);
                                        context.router.pop(true);
                                        context.router.pop(true);
                                        context.router.push(BookClubInfoRoute(
                                            bookId: clubId));
                                      }
                                    },
                                    isAsync: true,
                                    reverse: false,
                                    text: 'Сохранить'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const WebErrorWidget(
                      size: 150, errorMessage: noInternetErrorMessage);
                } else {
                  // By default, show a loading spinner.
                  return const Center(
                      child: CircularProgressIndicator(color: primaryColor));
                }
              });
        }));
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(
          Icons.lock_outline_rounded,
          color: secondaryColor,
        );
      }
      return null;
    },
  );

  String getStringFromDate() {
    initializeDateFormatting("ru_RU", null).then((_) {
      return DateFormat('dd MMM yyyy HH:mm', 'ru_RU').format(_dateTime);
    });
    return DateFormat('dd MMM yyyy HH:mm', 'ru_RU').format(_dateTime);
  }

  bool checkRestrictions(BuildContext context) {
    String? errorMessage;
    if (_name.trim().isEmpty) {
      errorMessage = "Название встречи не может быть пустым";
    } else if (_place.trim().isEmpty) {
      errorMessage = "Место встречи не может быть пустым";
    } else if (_dateTime.isBefore(DateTime.now()) ||
        _dateTime.isAtSameMomentAs(DateTime.now())) {
      errorMessage = "Дата встречи не может быть в прошлом";
    }

    if (errorMessage == null) {
      return true;
    }

    Flushbar(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(10),
      backgroundColor: redColor,
      messageText: Text(
        errorMessage,
        style: const TextStyle(
            fontSize: 14.0, color: whiteColor, fontWeight: FontWeight.w500),
      ),
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: whiteColor,
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
    return false;
  }

  Widget textTitle(Size size, String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        '$text:',
        style: TextStyle(
            //color: grayColor,
            fontSize: size.width / 22,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
