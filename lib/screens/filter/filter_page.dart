import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../components/routes/route.gr.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPage();
}

class _FilterPage extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: SingleChildScrollView(reverse: false, child: Text('FILTERS'))));
  }
}