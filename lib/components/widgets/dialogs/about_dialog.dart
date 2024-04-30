import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../image_constants.dart';

class AboutAppDialog extends Dialog {
  const AboutAppDialog({Key? key}) : super(key: key);

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
          height: size.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: size.width / 15,
                  ),
                  const Spacer(),
                  Text('О приложении',
                      style: TextStyle(
                          fontFamily: 'VelaSansExtraBold',
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Icon(
                    Icons.info_outline_rounded,
                    size: size.width / 15,
                  ),
                ],
              ),
              const Divider(color: primaryColor),
              const SizedBox(height: 10),
              Image.network(
                logoImg,
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 5),
              Text(
                'Shelfie',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: size.width / 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Версия: 1.5.9.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size.width / 22, fontWeight: FontWeight.normal),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Год создания: 2023',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: size.width / 22, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 15),
              DialogButton(
                  press: () {
                    context.router.pop();
                  },
                  isAsync: true,
                  reverse: true,
                  text: 'OK'),
            ],
          ),
        ),
      ),
    );
  }
}
