import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../components/constants.dart';
import '../../../../models/inherited_id.dart';

class ClubMembersPage extends StatefulWidget {
  final int clubId;

  const ClubMembersPage({Key? key, required this.clubId}) : super(key: key);

  @override
  State<ClubMembersPage> createState() => _ClubMembersPage();
}

class _ClubMembersPage extends State<ClubMembersPage>
    with SingleTickerProviderStateMixin {
  late int id;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(reverse: false, child: Text('Events')),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}