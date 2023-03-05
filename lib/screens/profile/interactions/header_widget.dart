import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String text;
  final String icon;

  const HeaderWidget({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: size.height * 0.05,
        ),
        Row(
          children: <Widget>[
            SizedBox(width: size.width * 0.075),
            SizedBox(
              height: size.height * 0.09,
              width: size.width * 0.09,
              child: Image.asset('assets/images/$icon.png'),
            ),
            const SizedBox(width: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'VelaSansExtraBold',
                  //color: Colors.black,
                  fontSize: size.width / 10,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ],
    );
  }
}
