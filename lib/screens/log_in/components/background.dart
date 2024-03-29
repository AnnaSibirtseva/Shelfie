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
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/books.png')),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.22,
                width: 300,
              ),
              Text(
                "SHELFIE",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'VelaSansExtraBold',
                    //color: Colors.black,
                    fontSize: size.width / 5,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                "Твой читательский дневник",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: size.width / 21),
              ),
              body
            ],
          ),
        ],
      ),
    );
  }
}
