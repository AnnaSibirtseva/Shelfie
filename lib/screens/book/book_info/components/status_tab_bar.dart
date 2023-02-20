import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class StatusTabBar extends StatefulWidget {
  const StatusTabBar({Key? key}) : super(key: key);

  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<StatusTabBar>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  List tabsText = ['Буду', 'Читаю', 'Перестал', 'Прочитал', 'Не читаю'];
  List tabsIcons = ['https://ie.wampi.ru/2023/02/20/image0b3013dedfe131f4c7.png'];

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.2,
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: primaryColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              tabs: [
                for (String tab in tabsText)
                  Tab(text: tab,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
