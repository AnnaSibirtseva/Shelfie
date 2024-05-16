import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../../models/server_exception.dart';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../text_fields/input_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'nothing_found_dialog.dart';

class AddCollectionDialog extends Dialog {
  final int userId;
  late String title = '', coverUrl = '', desc = '';

  AddCollectionDialog(this.userId, {Key? key}) : super(key: key);

  Future<void> createCollection() async {
    var client = http.Client();
    final jsonString = json.encode({
      "name": title,
      "description": desc,
      if (coverUrl.trim().isNotEmpty) "imageUrl": coverUrl
    });
    try {
      var response = await client.post(
          Uri.https(url, '/shelves/collections/create'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': userId.toString()
          },
          body: jsonString);
      if (errorWithMsg.contains(response.statusCode)) {
        var ex = ServerException.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
        throw Exception(ex.getMessage());
      } else if (response.statusCode != 200) {
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SingleChildScrollView(
        reverse: false,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: size.width * 0.8,
          height: size.height * 0.75,
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
                  Text('Новый сборник',
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
                      '🔹 Обложка:',
                      style: TextStyle(
                          fontSize: size.width / 22,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              InputTextField(
                onChanged: (String value) {
                  coverUrl = value;
                },
                maxLen: 0,
                height: 0.1,
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '🔹 Название:',
                  style: TextStyle(
                      fontSize: size.width / 22, fontWeight: FontWeight.bold),
                ),
              ),
              InputTextField(
                maxLen: 50,
                height: 0.1,
                onChanged: (String value) {
                  title = value;
                },
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '🔹 Описание:',
                  style: TextStyle(
                      fontSize: size.width / 22, fontWeight: FontWeight.bold),
                ),
              ),
              InputTextField(
                maxLen: 250,
                height: 0.15,
                onChanged: (String value) {
                  desc = value;
                },
              ),
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
                        if (checkRestrictions(context)) {
                          await createCollection();
                          context.router.pop();
                        }
                      } on Exception catch (_) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => const Center(
                                child: NothingFoundDialog(
                                    'Что-то пошло не так!\nНе получилось добавить новый сборник.',
                                    warningGif,
                                    'Ошибка')));
                      }
                    },
                    reverse: false,
                    text: 'Добавить',
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

  bool checkRestrictions(BuildContext context) {
    if (title.length < minCollectionTitle) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text("Название сборника должно быть от 2 символов")));
      return false;
    }
    return true;
  }
}
