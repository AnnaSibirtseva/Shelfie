import 'package:flutter/material.dart';

class FilterText extends StatelessWidget {
  final String text;
  final String? icon;

  const FilterText({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.001, horizontal: size.width * 0.05),
      height: size.height * 0.08,
      child: Stack(
        children: <Widget>[
          if (icon != null)
            Positioned(
                bottom: 0,
                top: 0,
                left: size.width * 0.2,
                child: SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.1,
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
                  fontSize: size.width / 17,
                  fontWeight: FontWeight.w800),
            ),
          )
        ],
      ),
    );
  }
}
