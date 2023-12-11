import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../models/top-10_book.dart';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../image_constants.dart';
import '../cards/top_10_card_light.dart';
import '../error.dart';
import 'nothing_found_dialog.dart';

class ChangeTop10Dialog extends Dialog {
  final int userId;
  final Top10BookInfo newBook;

  const ChangeTop10Dialog(this.userId, this.newBook, {Key? key})
      : super(key: key);

  Future<List<Top10BookInfo>> getUserTopBooks() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(url, '/books/top/$userId'));
      if (response.statusCode == 200) {
        return Top10BookListLight.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .topBooks;
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<void> saveUserTopBooks(
      List<Top10BookInfo> books) async {
    var client = http.Client();
    final jsonString =
        json.encode({"bookIds": books.map((book) => book.getId()).toList()});
    try {
      var response =
          await client.post(Uri.https(url, '/books/top/$userId/save-top'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
              },
              body: jsonString);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Dialog build(BuildContext context) {
    Top10CardLight? top10List;
    Size size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SingleChildScrollView(
        reverse: false,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: size.width * 0.8,
          height: size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.stars_rounded,
                    size: size.width / 15,
                  ),
                  const Spacer(),
                  Text('Добавить в топ-10',
                      style: TextStyle(
                          fontFamily: 'VelaSansExtraBold',
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Icon(
                    Icons.stars_rounded,
                    size: size.width / 15,
                  ),
                ],
              ),
              const Divider(color: primaryColor),
              const SizedBox(height: 10),
              SizedBox(
                height: size.height * 0.5,
                child: FutureBuilder<List<Top10BookInfo>>(
                    future: getUserTopBooks(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Top10BookInfo>> snapshot) {
                      if (snapshot.hasData) {
                        top10List = Top10CardLight(
                          books: snapshot.data!,
                          newBook: newBook,
                        );
                        return SingleChildScrollView(
                            reverse: false,
                            child: Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(5),
                                    height: size.height * 0.5,
                                    width: size.width * 0.9,
                                    child: top10List)
                              ],
                            ));
                      } else if (snapshot.hasError) {
                        return WebErrorWidget(
                            errorMessage: snapshot.error.toString());
                      } else {
                        return const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor));
                      }
                    }),
              ),
              const SizedBox(height: 15),
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
                        try {
                          if (top10List != null) {
                            await saveUserTopBooks(top10List!.getBooks());
                          }
                          context.router.pop();
                        } on Exception catch (_) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const Center(
                                  child: NothingFoundDialog(
                                      'Что-то пошло не так!\nНе удалось изменить топ-10',
                                      warningGif,
                                      'Ошибка')));
                        }

                        // todo warning about 11th book
                        // if (checkRestrictions(context)) {
                        //   await addReview(context);
                        //   context.router.pop(true);
                        // }
                      },
                      isAsync: true,
                      reverse: false,
                      text: 'Применить'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
