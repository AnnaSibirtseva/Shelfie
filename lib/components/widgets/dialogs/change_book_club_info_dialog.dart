import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie_diploma_app/components/widgets/hint_dialog_text.dart';
import 'dart:convert';
import 'dart:io';
import '../../../models/filters.dart';
import '../../../models/tag.dart';
import '../../../screens/filter/conponents/filter_list.dart';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../text_fields/input_text_field.dart';
import '../error.dart';
import 'nothing_found_dialog.dart';

class ChangeClubInfoDialog extends Dialog {
  final int userId;
  final int clubId;

  late String _name = '';
  late String _description = '';
  late String _coverImageUrl = '';
  late String _bannerImageUrl = '';

  late FilterList tags = FilterList(data: const []);
  late List<ClubTag> fullTags;
  late List<String> tagNames = [];
  late bool isPublic = true;

  ChangeClubInfoDialog({Key? key, required this.userId, required this.clubId})
      : super(key: key);

  List<String> getSelectedTags() {
    List<String> ids = [];
    for (var item in fullTags) {
      if (tags.selectedItemsList.contains(item.getTagName())) {
        ids.add(item.getId().toString());
      }
    }
    return ids;
  }

  Future<List<ClubTag>> getTags() async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.https(url, '/clubs/search/tags'), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        return BookClubFilters.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .tags;
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<void> addClub(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({
      "name": _name,
      "description": _description,
      if (_coverImageUrl.trim().isNotEmpty) "coverImageUrl": _coverImageUrl,
      //"bannerImageUrl": ,
      "isPublic": isPublic,
      "tagIds": getSelectedTags(),
    });
    try {
      var response = await client.post(Uri.https(url, '/clubs/create'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': userId.toString()
          },
          body: jsonString);
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) => const Center(
                child: NothingFoundDialog(
                    'Что-то пошло не так!\n Не удалось изменить информацию о клубе.',
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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
                        Text('Настройки',
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
                      onChanged: (String value) {
                        _name = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    textTitle(size, 'Описание'),
                    InputTextField(
                      maxLen: 250,
                      height: 0.2,
                      onChanged: (String value) {
                        _description = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    textTitle(size, 'Аватар'),
                    InputTextField(
                      maxLen: 0,
                      height: 0.1,
                      hintText: 'Прямая ссылка на изображение',
                      onChanged: (String value) {
                        _coverImageUrl = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    textTitle(size, 'Баннер'),
                    InputTextField(
                      maxLen: 0,
                      height: 0.1,
                      hintText: 'Прямая ссылка на изображение',
                      onChanged: (String value) {
                        _bannerImageUrl = value;
                      },
                    ),
                    const SizedBox(height: 5),
                    textTitle(size, 'Теги'),
                    const HintDialogText(
                        text:
                            'Теги - особенности клуба, по которым пользователи cмогут его найти.'
                            '\nКаждый клуб может иметь не более 5 меток.'),
                    SizedBox(
                      height: size.height * 0.25,
                      child: FutureBuilder<List<ClubTag>>(
                          future: getTags(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ClubTag>> snapshot) {
                            if (snapshot.hasData) {
                              fullTags = snapshot.data!;
                              for (var tag in fullTags) {
                                tagNames.add(tag.getTagName());
                              }
                              var saved = tags.selectedItemsList;
                              tags = FilterList(
                                data: tagNames,
                              );
                              tags.maxElems = 5;
                              tags.selectedItemsList = saved;
                              return SingleChildScrollView(child: tags);
                            } else if (snapshot.hasError) {
                              return WebErrorWidget(
                                  errorMessage: snapshot.error.toString());
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor));
                            }
                          }),
                    ),
                    const SizedBox(height: 10),
                    textTitle(size, 'Приватность'),
                    Row(
                      children: [
                        Text(
                          'Закрытый клуб',
                          style: TextStyle(
                              fontSize: size.width / 26,
                              fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Switch(
                          thumbIcon: thumbIcon,
                          value: !isPublic,
                          onChanged: (bool value) {
                            setState(() {
                              isPublic = !value;
                            });
                          },
                          inactiveThumbColor: grayColor,
                          inactiveTrackColor: secondaryColor,
                          activeTrackColor: secondaryColor,
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                    const HintDialogText(
                        text:
                            'Приватный клуб – литературный клуб, информацию которого могут просматривать только его участники. '
                            '\n\nДругие пользователи не будут видеть события такого книжного клуба, '
                            'пока кто-то из администраторов не одобрит их заявку на вступление.'),
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
                            press: () async {
                              if (_name.trim().isNotEmpty) {
                                //await addClub(context);
                                context.router.pop(true);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: redColor,
                                        content: Text(
                                            "Имя клуба не не может быть пустым!")));
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

  bool checkRestrictions(BuildContext context) {
    if (_name.length < minQuoteText) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text("Текст цитаты должен быть от 2 символов")));
      return false;
    }
    return true;
  }

  bool checkNameRestrictions(BuildContext context) {
    if (_name.length < minQuoteText) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text("Текст цитаты должен быть от 2 символов")));
      return false;
    }
    return true;
  }
}
