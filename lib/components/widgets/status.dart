import 'package:flutter/material.dart';

import '../../models/book_status.dart';

class StatusWidget extends StatefulWidget {
  final BookStatus bookState;

  @override
  StatusWidgetState createState() => StatusWidgetState();

  const StatusWidget({Key? key, required this.bookState}) : super(key: key);
}

class StatusWidgetState extends State<StatusWidget> {
  BookStatus bookState = BookStatus.None;

  StatusWidgetState();

  @override
  void initState() {
    super.initState();
    bookState = widget.bookState;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (bookState == BookStatus.None) {
              bookState = BookStatus.Planning;
            } else {
              bookState = BookStatus.None;
            }
          });
        },
        onDoubleTap: () {
          setState(() {
            if (bookState != BookStatus.Finished) {
              bookState = BookStatus.Finished;
            }
          });
        },
        child: SizedBox(
          height: 35,
          width: 35,
          child: Image.asset(getStateIcon(bookState)),
        ));
  }

  String getStateIcon(BookStatus status) {
    switch (status) {
      case BookStatus.None:
        return 'assets/icons/add.png';
      case BookStatus.InProgress:
        return 'assets/icons/in_prog.png';
      case BookStatus.Finished:
        return 'assets/icons/finished.png';
      case BookStatus.Planning:
        return 'assets/icons/planning.png';
      case BookStatus.Dropped:
        return 'assets/icons/dropped.png';
    }
  }
}
