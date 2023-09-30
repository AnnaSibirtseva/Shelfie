import 'package:flutter/material.dart';

import '../../../components/constants.dart';

class SliderWidget extends StatefulWidget {
  late double _value = 0.0;

  SliderWidget({Key? key}) : super(key: key);

  @override
  _Slider createState() => _Slider();

  double getRating() {
    return _value;
  }
}

class _Slider extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
            width: size.width * 0.8,
            child: Slider(
              min: 0.0,
              max: 10.0,
              value: widget._value,
              divisions: 10,
              label: '${widget._value.round()}',
              activeColor: primaryColor,
              inactiveColor: secondaryColor,
              thumbColor: primaryColor,
              onChanged: (value) {
                setState(() {
                  widget._value = value;
                });
              },
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.star_border_rounded,
                color: primaryColor,
                size: size.width * 0.055,
              ),
              Text('${widget._value.round()}/10',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: size.width * 0.042,
                      fontWeight: FontWeight.bold))
            ],
          ),
        )
      ],
    );
  }
}
