import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../components/constants.dart';
import '../../../models/event_review.dart';
import '../../../models/inherited_id.dart';

class EventReviewCard extends StatefulWidget {
  final EventReview review;
  final Function() notifyParent;

  const EventReviewCard({
    Key? key,
    required this.review,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<EventReviewCard> createState() => _EventReviewCardState();
}

class _EventReviewCardState extends State<EventReviewCard> {
  bool showFlag = false;
  late int id;

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String revText = widget.review.getText();
    Size size = MediaQuery.of(context).size;

    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.only(top: 10, bottom: 15, left: 15),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                          radius: 23,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.review.getAliasImageUrl(),
                            ),
                            maxRadius: 25,
                          )),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          widget.review.getAliasName(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: primaryColor,
                              size: 21,
                            ),
                            const SizedBox(width: 5),
                            Text(
                                widget.review.getRating(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: size.width * 0.04))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text(
                widget.review.getText(),
                textAlign: TextAlign.justify,
                maxLines: showFlag ? null : 7,
                style: TextStyle(
                    fontSize: size.width / 28, fontWeight: FontWeight.w500),
              ),
            ),
            if (revText.isNotEmpty && ('\n'.allMatches(revText).length + 1) > 6)
              InkWell(
                  onTap: () {
                    setState(() {
                      showFlag = !showFlag;
                    });
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(showFlag ? "Свернуть" : "Развернуть",
                              style: const TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  )),
          ],
        ),
      ),
    );
  }
}
