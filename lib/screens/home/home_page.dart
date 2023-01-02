import 'package:flutter/material.dart';
import '../../components/bottom_menu/bottom_bar_item.dart';

import '../../components/bottom_menu/bottom_bar_bubble.dart';
import '../collections/collection_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedTab = 0;
  static const List<Widget> _list = <Widget>[
    CollectionsPage(),
    Text('Поиск'),
    Text('Профиль')
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarBubble(
        selectedIndex: _selectedTab,
        items: [
          BottomBarItem(iconData: Icons.home_rounded),
          BottomBarItem(iconData: Icons.search_rounded),
          BottomBarItem(iconData: Icons.person_rounded),
        ],
        onSelect: onSelectTab,
      ),
      body: Center(
        child: _list[_selectedTab],
      ),
    );
  }
}
