import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../../../models/book.dart';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../text_fields/input_text_field.dart';
import 'nothing_found_dialog.dart';

class AddQuoteDialog extends Dialog {
  final Book book;
  final int id;
  late String _text = '';

  AddQuoteDialog({Key? key, required this.book, required this.id})
      : super(key: key);

  Future<void> addQuote(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({"bookId": book.getId(), "text": _text});
    try {
      var response = await client.post(
          Uri.https(url, '/interactions/quotes/add'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          },
          body: jsonString);
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) => const Center(
                child: NothingFoundDialog(
                    'Что-то пошло не так!\nЦитата не была добавлена.',
                    warningGif,
                    'Ошибка')));
      }
    } finally {
      client.close();
    }
  }

  @override
  Dialog build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SingleChildScrollView(
        reverse: false,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: size.width * 0.8,
          height: size.height * 0.6,
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
                  Text('Новая цитата',
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
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '📔 Произведение:',
                  style: TextStyle(
                      color: grayColor,
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '"' + book.getTitle() + '"',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: size.width / 24, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '- ' +
                      (book.getAuthors().isNotEmpty
                          ? book.getAuthors()[0]
                          : "- - -") +
                      ' -',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: size.width / 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '🖋️ Цитата:',
                  style: TextStyle(
                      color: grayColor,
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InputTextField(
                maxLen: 1500,
                height: 0.2,
                onChanged: (String value) {
                  _text = value;
                },
              ),
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
                      press: () async {
                        if (_text.isNotEmpty && checkRestrictions(context)) {
                          await addQuote(context);
                          context.router.pop(true);
                        } else {
                          Flushbar(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(10),
                            backgroundColor: redColor,
                            messageText: const Text(
                              "Цитата не может быть пустой!",
                              style: TextStyle(
                                  fontSize: 14.0, color: whiteColor, fontWeight: FontWeight.w500),
                            ),
                            icon: const Icon(
                              Icons.info_outline,
                              size: 28.0,
                              color: whiteColor,
                            ),
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        }
                      },
                      isAsync: true,
                      reverse: false,
                      text: 'Добавить'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkRestrictions(BuildContext context) {
    if (_text.length < minQuoteText) {
      Flushbar(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(10),
        backgroundColor: redColor,
        messageText: const Text(
          "Текст цитаты должен быть от 2 символов",
          style: TextStyle(
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
    return true;
  }
}
