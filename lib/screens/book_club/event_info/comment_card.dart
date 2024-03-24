import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../components/constants.dart';
import '../../../components/image_constants.dart';
import '../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../models/comment.dart';
import '../../../models/inherited_id.dart';
import '../../../models/parser.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;

  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool showFlag = false;

  @override
  Widget build(BuildContext context) {
    String revText = widget.comment.getText();
    Size size = MediaQuery.of(context).size;

    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.all(15),
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
                          radius: 27,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.comment.getImageUrl(),
                            ),
                            maxRadius: 25,
                          )),
                      const SizedBox(width: 15),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.comment.getUserName(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            getStringFromDate(widget.comment.getCreatedDT()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: darkGrayColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              widget.comment.getText(),
              textAlign: TextAlign.justify,
              maxLines: showFlag ? null : 7,
              style: TextStyle(
                  fontSize: size.width / 28, fontWeight: FontWeight.normal),
            ),
            if (revText.isNotEmpty && revText.length > 300)
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
