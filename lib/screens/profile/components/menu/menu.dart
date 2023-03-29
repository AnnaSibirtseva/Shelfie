import 'package:flutter/material.dart';

import 'menu_list_item.dart';

class Menu extends StatelessWidget {
  final List titles;
  final List routes;

  const Menu({Key? key, required this.titles, required this.routes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        width: size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var item = 0; item < titles.length; item++)
                MenuListItem(press: routes[item], text: titles[item])
            ])

        //   ListView.builder(
        //   itemCount: titles.length,
        //   itemBuilder: (context, index) =>
        //       MenuListItem(
        //         text: titles[index],
        //         press: () {},
        //       ),
        // ),)
        );
  }
}
