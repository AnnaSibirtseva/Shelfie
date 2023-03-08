import 'package:flutter/material.dart';

import '../../../../components/widgets/dialogs/add_collection_dialog.dart';

class PageTitleWidget extends StatelessWidget {
  const PageTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  builder: (BuildContext context) => const AddCollectionDialog()),
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
