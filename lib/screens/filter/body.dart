import 'package:flutter/material.dart';
import 'package:shelfie/components/routes/route.gr.dart';
import 'package:auto_route/auto_route.dart';

import 'conponents/filter_text.dart';
import 'conponents/filter_list.dart';
import 'conponents/slider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: size.height * 0.01,),
          FilterText(text: 'Жанр', icon: 'mask',),
          FilterList(),
          FilterText(text: 'Страна', icon: 'flag',),
          FilterText(text: 'Рейтинг', icon: 'star',),
          SliderWidget(),
          FilterText(text: 'Другое', icon: 'info',),
        ],
      ),
    );
  }
}
