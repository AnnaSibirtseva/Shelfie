import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget body;

  const Background({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: size.height * 0.2,
                width: size.width * 0.57,
                child: Image.asset('assets/images/top_left_triangle.png'),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: size.height * 0.45,
                width: size.width * 0.4,
                child: Image.asset('assets/images/center_triangle.png'),
              )),
          Column(
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
                    child: Image.asset('assets/images/book_shelf.png'),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Подборки",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'VelaSansExtraBold',
                        //color: Colors.black,
                        fontSize: size.width / 10,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: size.width * 0.075),
                  Text(
                    "Зацените наш топ подборок",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: size.width / 25),
                  ),
                ],
              ),
              body,
              SizedBox(height: 71),
            ],
          ),
        ],
      ),
    );
  }
}
