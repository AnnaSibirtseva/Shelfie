import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../../../models/comment.dart';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../text_fields/input_text_field.dart';
import 'nothing_found_dialog.dart';

class EditCommentDialog extends Dialog {
  final int userId;
  final Comment comment;
  final Function notifyParent;

  bool _isButtonDisabled = false;
  late String _text;

  EditCommentDialog({
    Key? key,
    required this.userId,
    required this.comment,
    required this.notifyParent,
  }) : super(key: key) {
    _text = comment.getText();
  }

  Future<void> editComment(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({"text": _text.trim()});
    try {
      var response = await client.put(
          Uri.https(url, '/events/comment/${comment.getId()}/edit'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': userId.toString()
          },
          body: jsonString);
      var msg = 'Что-то пошло не так!\n Не удалось изменить комментарий.';
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
  Dialog build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: SingleChildScrollView(
          reverse: false,
          child: Container(
            padding: const EdgeInsets.all(15),
            width: size.width * 0.8,
            height: size.height * 0.45,
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
                      Text('Редактирование',
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
                  textTitle(size, 'Комментарий'),
                  InputTextField(
                    maxLen: 1000,
                    height: 0.2,
                    defaultText: _text,
                    onChanged: (String value) {
                      _text = value;
                    },
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
                          press: _isButtonDisabled
                              ? () => {}
                              : () async {
                                  _isButtonDisabled = true;
                                  if (checkRestrictions(context)) {
                                    await editComment(context);
                                    comment.changeText(_text.trim());
                                    notifyParent();
                                    context.router.pop(true);
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
        ));
  }

  bool checkRestrictions(BuildContext context) {
    if (_text.trim().isNotEmpty) {
      return true;
    }
    Flushbar(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(10),
      backgroundColor: redColor,
      messageText: const Text(
        "Текст комментария не может быть пустым",
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
