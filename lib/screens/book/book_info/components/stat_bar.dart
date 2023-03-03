import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/models/book_status.dart';

class BookStatisticsTabBar extends StatefulWidget {
  const BookStatisticsTabBar({Key? key}) : super(key: key);

  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<BookStatisticsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabsText = ['Рецензии', 'Цитаты'];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.5,
      width: size.width,
      //padding: const EdgeInsets.symmetric(vertical: 13),
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
              //isScrollable: true,
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: primaryColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              tabs: [
                for (String tab in tabsText)
                  // todo add number of stat
                  Tab(text: tab)
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Center(
                  child: Text(
                    'Вкладка Рецензий',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // second tab bar view widget
                Center(
                  child: Text(
                    'Вкладка Цитат',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
