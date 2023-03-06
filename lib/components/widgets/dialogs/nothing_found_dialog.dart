// https://www.flaticon.com/free-animated-icon/search_8722522?term=book&page=1&position=7&origin=search&related_id=8722522
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../text_fields/input_text_field.dart';

class NothingFoundDialog extends Dialog {
  final String text;
  final String imageUrl;

  const NothingFoundDialog(this.text, this.imageUrl, {Key? key}) : super(key: key);

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
          height: size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: size.width / 15,
                  ),
                  const Spacer(),
                  Text('Не найдено',
                      style: TextStyle(
                          fontFamily: 'VelaSansExtraBold',
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Icon(
                    Icons.warning_amber_rounded,
                    size: size.width / 15,
                  ),
                ],
              ),
              const Divider(color: primaryColor),
              const SizedBox(height: 10),
              Image.network(
                imageUrl,
                height: 100,
                width: 100,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 15),
             DialogButton(
                      press: () {
                        context.router.pop();
                      },
                      reverse: true,
                      text: 'OK'),

            ],
          ),
        ),
      ),
    );
  }
}
