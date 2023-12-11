import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import '../../../models/book.dart';
import 'dart:convert';
import 'dart:io';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../text_fields/input_text_field.dart';
import '../rating_widget.dart';
import 'nothing_found_dialog.dart';

class AddReviewDialog extends Dialog {
  final Book book;
  final int id;
  late String _text = '';
  late int _rating = 0;
  late String _title = '';

  AddReviewDialog({Key? key, required this.book, required this.id})
      : super(key: key);

  Future<void> addReview(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({
      "bookId": book.getId(),
      "title": _title,
      "text": _text,
      "rating": _rating
    });
    try {
      var response = await client.post(
          Uri.https(url, '/interactions/reviews/add'),
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
                    'Что-то пошло не так!\nРецензия не была добавлена.',
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
          height: size.height * 0.84,
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
                  Text('Новая рецензия',
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
              //const SizedBox(height: 10),
              textWidget('Произведение:', size),
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
              textWidget('Оценка:', size),
              StatefulBuilder(
                builder: (context, setState) {
                  return StarRating(
                    onChanged: (index) {
                      setState(() {
                        _rating = index;
                      });
                    },
                    value: _rating,
                  );
                },
              ),
              const SizedBox(height: 5),
              textWidget('Название:', size),
              InputTextField(
                onChanged: (String value) {
                  _title = value;
                },
                maxLen: 150,
                height: 0.1,
              ),
              const SizedBox(height: 5),
              textWidget('Рецензия:', size),
              InputTextField(
                maxLen: 5000,
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
                        if (checkRestrictions(context)) {
                            await addReview(context);
                            context.router.pop(true);
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
    if (_title.isEmpty && _text.isEmpty) {
      return true;
    }
    if (_title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text("Название рецензии не может быть пустым")));
      return false;
    }
    if (_text.length < minRevText) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text("Текст рецензии должен быть от 10 символов")));
      return false;
    }
    return true;
  }

  Widget textWidget(String text, Size size) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
            color: grayColor,
            fontSize: size.width / 23,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
