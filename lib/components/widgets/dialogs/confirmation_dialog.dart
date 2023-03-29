import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';

class ConfirmationDialog extends Dialog {
  final String text;
  final VoidCallback press;

  const ConfirmationDialog({Key? key, required this.text, required this.press})
      : super(key: key);

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
          height: size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: size.width / 15,
                  ),
                  const Spacer(),
                  Text('Подтверждение',
                      style: TextStyle(
                          fontFamily: 'VelaSansExtraBold',
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: size.width / 15,
                  ),
                ],
              ),
              const Divider(color: primaryColor),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size.width / 22, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                      press: () {
                        context.router.pop();
                      },
                      isAsync: true,
                      reverse: false,
                      text: 'Отменить'),
                  const SizedBox(
                    width: 10,
                  ),
                  DialogButton(
                      press: press,
                      isAsync: true,
                      reverse: true,
                      text: 'Удалить'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
