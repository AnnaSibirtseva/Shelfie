import 'package:flutter/material.dart';

class EventInfoPage extends StatefulWidget {
  final int eventId;

  const EventInfoPage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventInfoPage> createState() => _EventInfoPage();
}

class _EventInfoPage extends State<EventInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(reverse: false, child: Text('Event Info')),
    );
  }
}
