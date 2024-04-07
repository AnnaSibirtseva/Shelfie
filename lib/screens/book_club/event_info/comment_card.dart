import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../components/constants.dart';
import '../../../components/image_constants.dart';
import '../../../components/widgets/dialogs/confirmation_dialog.dart';
import '../../../components/widgets/dialogs/edit_comment_dialog.dart';
import '../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../models/comment.dart';
import '../../../models/inherited_id.dart';
import '../../../models/parser.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final Function() notifyParent;

  const CommentCard({
    Key? key,
    required this.comment,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool showFlag = false;
  late int id;

  Future<void> deleteComment() async {
    var client = http.Client();
    try {
      var response = await client.delete(
          Uri.https(url, '/events/comment/${widget.comment.getId()}/delete'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString(),
          });
      var msg = 'Что-то пошло не так!\n Не удалось удалить комментарий.';
      if (response.statusCode != 200) {
        if ([400, 404, 403].contains(response.statusCode)) {
          msg = response.toString();
        }
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                Center(child: NothingFoundDialog(msg, warningGif, 'Ошибка')));
      }
    } finally {
      client.close();
    }
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String revText = widget.comment.getText();
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
                if (widget.comment.getCanBeEditedByUser() ||
                    widget.comment.getCanBeDeletedByUser())
                  Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton(
                        onSelected: (value) {
                          switch (value) {
                            case 'delete':
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ConfirmationDialog(
                                        text:
                                            'Вы дейстивтельно хотите удалить этот комментарий?',
                                        press: () async {
                                          await deleteComment();
                                          context.router.pop(true);
                                          widget.notifyParent();
                                        },
                                      ));
                            case 'edit':
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      EditCommentDialog(
                                        userId: inheritedWidget.id,
                                        comment: widget.comment,
                                        notifyParent: widget.notifyParent,
                                      )).then(refresh());
                          }
                        },
                        icon: Icon(
                          Icons.adaptive.more,
                          color: primaryColor,
                        ),
                        color: secondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        itemBuilder: (BuildContext bc) {
                          return [
                            if (widget.comment.getCanBeEditedByUser())
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.mode_edit_rounded,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Редактировать")
                                  ],
                                ),
                              ),
                            if (widget.comment.getCanBeDeletedByUser())
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_rounded,
                                      color: brightRedColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Удалить",
                                        style: TextStyle(
                                          color: brightRedColor,
                                        ))
                                  ],
                                ),
                              ),
                          ];
                        }),
                  )
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text(
                widget.comment.getText(),
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
