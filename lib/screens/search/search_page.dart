import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/buttons/filter_button.dart';
import '../../components/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final _searchController = TextEditingController();

  void _searchBooks() {}

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_searchBooks);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // keyboard ScrollViewDismissBehavior on drag
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              const FilterButton(
                pressed: false,
              ),
              searchField(size),
            ],
          )
        ],
      ),
    );
  }

  Widget searchField(Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 20),
      padding: const EdgeInsets.only(left: 20, right: 7, top: 5, bottom: 5),
      width: size.width * 0.71,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor)),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: _searchController,
        style: const TextStyle(fontSize: 20),
        cursorColor: primaryColor,
        decoration: const InputDecoration(
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
