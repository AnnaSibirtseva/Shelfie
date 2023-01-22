import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  _Slider createState() => _Slider();
}

class _Slider extends State<SliderWidget> {
  double _value = 5.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
            width: size.width * 0.8,
            child: Slider(
              min: 0.0,
              max: 10.0,
              value: _value,
              divisions: 10,
              label: '${_value.round()}',
              activeColor: primaryColor,
              inactiveColor: secondaryColor,
              thumbColor: primaryColor,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            )),
        SizedBox(
          width: size.width * 0.2,
          child: Row(
            children: [
              Icon(
                Icons.star_border_rounded,
                color: primaryColor,
                size: size.width * 0.055,
              ),
              Text('${_value.round()}/10',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.bold))
            ],
          ),
        )
      ],
    );
  }
}
