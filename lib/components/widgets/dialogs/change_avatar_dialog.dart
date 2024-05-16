import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../text_fields/input_text_field.dart';
import 'nothing_found_dialog.dart';

class ChangeAvatarDialog extends Dialog {
  final int userId;
  final Function() notifyParent;

  ChangeAvatarDialog(this.userId, this.notifyParent, {Key? key})
      : super(key: key);

  late String newAvatar;

  Future<void> setAvatar(String newAvatar) async {
    var client = http.Client();
    final jsonString = json.encode({'avatarUrl': newAvatar});
    try {
      var response = await client.put(
          Uri.https(url, '/users/user/${userId.toString()}/set-avatar'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  String getAvatar() {
    return newAvatar;
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
          height: size.height * 0.37,
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
                  Text('Новый аватар',
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
                child: Tooltip(
                    message: 'Прямая ссылка на изображение',
                    child: Text(
                      '🖼️ Изображение',
                      style: TextStyle(
                          fontSize: size.width / 23,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              InputTextField(
                onChanged: (String value) {
                  newAvatar = value;
                },
                maxLen: 0,
                height: 0.1,
                hintText: "Прямая ссылка на изображение",
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                      press: () {
                        context.router.pop();
                      },
                      isAsync: true,
                      reverse: true,
                      text: 'Отменить'),
                  const SizedBox(
                    width: 10,
                  ),
                  DialogButton(
                    press: () async {
                      try {
                        await setAvatar(newAvatar);
                        notifyParent();
                        context.router.pop();
                      } on Exception catch (_) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => const Center(
                                child: NothingFoundDialog(
                                    'Что-то пошло не так!\nАватар не был изменен.',
                                    warningGif,
                                    'Ошибка')));
                      }
                    },
                    reverse: false,
                    text: 'Изменить',
                    isAsync: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
