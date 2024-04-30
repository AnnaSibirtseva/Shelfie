import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import '../../../models/club_event.dart';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../../text_fields/input_text_field.dart';
import '../rating_widget.dart';
import 'nothing_found_dialog.dart';

class AddEventReviewDialog extends Dialog {
  final int userId;
  final BookClubEvent event;
  final Function() notifyParent;

  late String _text = '';
  late int _rating = 0;
  Random random = Random();

  AddEventReviewDialog({
    Key? key,
    required this.event,
    required this.userId,
    required this.notifyParent,
  }) : super(key: key);

  Future<void> addReview(BuildContext context) async {
    var client = http.Client();

    final jsonString = json.encode({
      "text": _text,
      "rating": _rating,
      "aliasId": random.nextInt(aliasesAmount) + 1
    });
    try {
      var response = await client.post(
          Uri.https(url, '/events/review/${event.getId()}/add'),
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
                    'Что-то пошло не так!\nОтзыв не была добавлен.',
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
          height: size.height * 0.66,
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
                  Text('Оценка встречи',
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
              eventInfo(size),
              const SizedBox(height: 10),
              textWidget('Оценка', size),
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
              textWidget('Отзыв', size),
              InputTextField(
                maxLen: 1000,
                height: 0.15,
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
                        await addReview(context);
                        context.router.pop(true);
                        notifyParent();
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

  Widget textWidget(String text, Size size) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
            color: blackColor,
            fontSize: size.width / 23,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget eventInfo(Size size) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '"${event.getTitle()}"',
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                fontSize: size.width / 22, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.white70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                height: size.height * 0.03,
                width: size.height * 0.03,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(defaultCollectionImg),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(event.getClubImg()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  event.getClubName(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: size.width / 24, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
