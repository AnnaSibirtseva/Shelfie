import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shelfie/models/inherited_id.dart';

import '../../../../components/widgets/dialogs/add_collection_dialog.dart';

class Body extends StatefulWidget {

  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final inheritedWidget = IdInheritedWidget.of(context);

    return Container(
      margin: EdgeInsets.only(
          left: 15, right: 15, top: 15, bottom: size.height * 0.1),
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          drawHead(context, size, inheritedWidget.id),
        ],
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  Widget drawHead(BuildContext context, Size size, int id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: size.height * 0.03,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.09,
              width: size.width * 0.09,
              child:
              //Image.network('https://disk.yandex.ru/i/i8FVLoIZxIl8xQ')
              Image.asset('assets/images/book_shelf.png'),
            ),
            const SizedBox(width: 10),
            Text(
              'Сборники',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'VelaSansExtraBold',
                  //color: Colors.black,
                  fontSize: size.width / 12,
                  fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AddCollectionDialog(id)).then(onGoBack),
              child: SizedBox(
                height: 35,
                width: 35,
                child: Image.asset('assets/icons/add.png'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
