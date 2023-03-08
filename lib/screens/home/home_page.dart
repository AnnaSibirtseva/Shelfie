import 'package:flutter/material.dart';
import '../../components/bottom_menu/bottom_bar_item.dart';

import '../../components/bottom_menu/bottom_bar_bubble.dart';
import '../../models/inherited_id.dart';
import '../collections/collection_page.dart';
import '../search/search_page.dart';
import 'package:auto_route/auto_route.dart';
import '../../components/routes/route.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedTab = 0;
  static const List<PageRouteInfo<dynamic>> _routes = [
    CollectionsRouter(),
    SearchRouter(),
    ProfileRouter()
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IdInheritedWidget(
        id: 1,
        child: Scaffold(
          body: AutoTabsRouter(
            routes: _routes,
            builder: (context, child, animation) {
              final tabsRouter = context.tabsRouter;
              return Scaffold(
                body: child,
                bottomNavigationBar: BottomBarBubble(
                  onSelect: tabsRouter.setActiveIndex,
                  selectedIndex: tabsRouter.activeIndex,
                  items: [
                    BottomBarItem(iconData: Icons.home_rounded),
                    BottomBarItem(iconData: Icons.search_rounded),
                    BottomBarItem(iconData: Icons.person_rounded),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
