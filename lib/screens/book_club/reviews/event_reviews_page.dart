import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../components/constants.dart';
import '../../../../models/inherited_id.dart';

class EventReviewsPage extends StatefulWidget {
  final int eventId;

  const EventReviewsPage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventReviewsPage> createState() => _EventReviewsPage();
}

class _EventReviewsPage extends State<EventReviewsPage>
    with SingleTickerProviderStateMixin {
  late int id;

  @override
  void initState() {
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
