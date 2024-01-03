import 'package:flutter/material.dart';
import '../../components/routes/route.gr.dart';
import '../../components/bottom_menu/bottom_bar_item.dart';

import '../../components/bottom_menu/bottom_bar_bubble.dart';
import '../../components/secure_storage/storage_item.dart';
import '../../models/inherited_id.dart';
import 'package:auto_route/auto_route.dart';

import '../splash/splash_page.dart';

class HomePage extends StatefulWidget {
  final int userId;

  const HomePage(this.userId, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late BuildContext curContext;

  static const List<PageRouteInfo<dynamic>> _routes = [
    CollectionsRouter(),
    SearchRouter(),
    BookClubsRouter(),
    ProfileRouter()
  ];

  void _selectTab(int index) {
    if ((index == curContext.tabsRouter.activeIndex)) {
      curContext.router.navigate(_routes[index]);
      curContext.router.pushNamed('/home');
      curContext.router.push(_routes[index]);
      setState(() {});
    } else {
      //curContext.tabsRouter.setActiveIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    storageService.writeSecureData(StorageItem("id", widget.userId.toString()));
    return IdInheritedWidget(
        id: widget.userId,
        child: Scaffold(
          body: AutoTabsRouter(
            routes: _routes,
            builder: (context, child, animation) {
              final tabsRouter = context.tabsRouter;
              curContext = context;
              return Scaffold(
                body: child,
                bottomNavigationBar: BottomBarBubble(
                  onSelect: tabsRouter.setActiveIndex,
                  onSelectAgain: _selectTab,
                  selectedIndex: tabsRouter.activeIndex,
                  items: [
                    BottomBarItem(iconData: Icons.home_rounded),
                    BottomBarItem(iconData: Icons.search_rounded),
                    BottomBarItem(iconData: Icons.groups_rounded),
                    BottomBarItem(iconData: Icons.person_rounded),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
