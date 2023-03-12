import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../text_fields/input_text_field.dart';

class AddCollectionDialog extends Dialog {
  const AddCollectionDialog({Key? key}) : super(key: key);

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
          height: size.height * 0.52,
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
                  '🖼️ Обложка:',
                  style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.bold),
                )),
              ),
              InputTextField(
                onChanged: (String value) {}, maxLen: 0, height: 0.1,
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '🖋️ Название:',
                  style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InputTextField(
                  maxLen: 50, height: 0.1,
                onChanged: (String value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                      press: () {
                        context.router.pop();
                      },
                      isAsync: false,
                      reverse: true,
                      text: 'Отменить'),
                  const SizedBox(
                    width: 10,
                  ),
                  DialogButton(press: () {}, reverse: false, text: 'Добавить', isAsync: false,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
