import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shelfie/components/constants.dart';
import '../../components/buttons/filter_button.dart';
import '../../components/routes/route.gr.dart';
import 'body.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPage();
}

class _FilterPage extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // keyboard ScrollViewDismissBehavior on drag
    return Scaffold(
      body: SingleChildScrollView(reverse: false, child: Stack(
        children: [
          Row(
            children: [
              const FilterButton(
                pressed: true,
              ),
              searchField(size),
            ],
          ),
          Column(
            children: [
              SizedBox(height: size.height * 0.1),
              Body(),
            ],
          )
        ],
      ),
      ),
    );
  }

  Widget searchField(Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 20),
      padding: const EdgeInsets.only(left: 20, right: 7, top: 5, bottom: 5),
      width: size.width * 0.71,
      height:  size.width * 0.15,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor, width: 1.5)),
      child: const TextField(
        keyboardType: TextInputType.emailAddress,
        // controller: _searchController,
        style: TextStyle(fontSize: 20),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search_rounded,
            color: grayColor,
            size: 35,
          ),
          hintStyle: TextStyle(color: grayColor, fontSize: 20),
          hintText: 'Найти книгу...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}