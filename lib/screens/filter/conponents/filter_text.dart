import 'package:flutter/material.dart';

class FilterText extends StatelessWidget {
  final String text;
  final String icon;

  const FilterText({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.001, horizontal: size.width * 0.05),
      width: size.width * 0.32,
      height: size.height * 0.08,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.12,
                child: Image.asset('assets/images/$icon.png'),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'VelaSansExtraBold',
                  //color: Colors.black,
                  fontSize: size.width / 13,
                  fontWeight: FontWeight.w800),
            ),
          )
        ],
      ),
    );
  }
}
