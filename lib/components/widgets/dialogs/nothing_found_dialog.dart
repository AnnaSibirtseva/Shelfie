import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';

class NothingFoundDialog extends Dialog {
  final String text;
  final String title;
  final String imageUrl;

  const NothingFoundDialog(this.text, this.imageUrl, this.title, {Key? key})
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
          height: size.height * 0.4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: size.width / 15,
                    ),
                    const Spacer(),
                    Text(title,
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
                  alignment: Alignment.topCenter,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
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
      ),
    );
  }
}
