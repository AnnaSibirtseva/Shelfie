import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../../text_fields/input_text_field.dart';

class AddQuoteDialog extends Dialog {

  const AddQuoteDialog({Key? key}) : super(key: key);

  @override
  Dialog build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SingleChildScrollView(
    reverse: false,
    child: Container(
        padding: const EdgeInsets.all(15),
        width: size.width * 0.8,
        height: size.height * 0.6,
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
                Text('Новая цитата',
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
            Align(alignment: Alignment.topLeft,
              child: Text(
                '📔 Произведение:',
                style: TextStyle(
                  color: grayColor,
                    fontSize: size.width / 22, fontWeight: FontWeight.bold),
              ),),
            const SizedBox(height: 10),
            Align(alignment: Alignment.topLeft,
              child: Text(
                '"' 'Странная история доктора Джекилла и мистера Хайда' '"',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: size.width / 24, fontWeight: FontWeight.w500),
              ),),
            const SizedBox(height: 5),
            Align(alignment: Alignment.topLeft,
              child: Text(
                '- ''Роберт Стивенсон'' -',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: size.width / 24, fontWeight: FontWeight.bold),
              ),),
            const SizedBox(height: 15),
            Align(alignment: Alignment.topLeft,
              child: Text(
                '🖋️ Цитата:',
                style: TextStyle(
                    color: grayColor,
                    fontSize: size.width / 22, fontWeight: FontWeight.bold),
              ),),

            // Note: Same code is applied for the TextFormField as well
            InputTextField(onChanged: (String value) {  },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogButton(press: () {  }, reverse: true, text: 'Отменить'),
                const SizedBox(width: 10,),
                DialogButton(press: () {  }, reverse: false, text: 'Добавить'),
              ],
            ),
            // TextButton(
            //     onPressed: () {
            //       context.router.pop();
            //     },
            //     child: Text(
            //       'Got It!',
            //       style: TextStyle(color: Colors.purple, fontSize: 18.0),
            //     ))
          ],
        ),
      ),
    ),);
  }
}
