import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../components/constants.dart';
import '../../../../components/image_constants.dart';
import '../../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../../models/club_requests.dart';
import '../../../../models/inherited_id.dart';
import '../../../../models/server_exception.dart';

class MembershipRequestCard extends StatefulWidget {
  final Function() notifyParent;
  final ClubRequest request;

  const MembershipRequestCard({
    Key? key,
    required this.notifyParent,
    required this.request,
  }) : super(key: key);

  @override
  State<MembershipRequestCard> createState() => _MembershipRequestCardState();
}

class _MembershipRequestCardState extends State<MembershipRequestCard> {
  late int id;

  Future<void> handleRequest(BuildContext context, int requestId, String type) async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https(url, '/clubs/admin/requests/$requestId/$type'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'adminId': id.toString(),
          });

      if (errorWithMsg.contains(response.statusCode)) {
        var ex = ServerException.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return NothingFoundDialog(ex.getMessage(), warningGif, 'Ошибка');
            });
      } else if (response.statusCode != 200) {
        throw Exception();
      }
    } on Exception {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const NothingFoundDialog(
                'Что-то пошло не так! Не удалось одобрить заявку пользователя.',
                warningGif,
                'Ошибка');
          });
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    Size size = MediaQuery.of(context).size;
    double cardHeight = size.height * 0.09;

    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
        height: cardHeight + 10,
        width: size.width,
        child: Row(
          children: [
            Container(
              width: cardHeight,
              height: cardHeight,
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: secondaryColor),
                image: const DecorationImage(
                  image: NetworkImage(defaultCollectionImg),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              foregroundDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: secondaryColor),
                image: DecorationImage(
                  image: NetworkImage(widget.request.getImageUrl()),
                  onError: (error, stackTrace) =>
                      const NetworkImage(defaultCollectionImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: TextScroll(widget.request.getName(),
                          intervalSpaces: 5,
                          velocity:
                              const Velocity(pixelsPerSecond: Offset(50, 0)),
                          fadedBorder: true,
                          fadeBorderVisibility: FadeBorderVisibility.auto,
                          fadeBorderSide: FadeBorderSide.right,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: blackColor,
                              fontSize: size.width * 0.045)),
                    ),
                    const SizedBox(height: 5),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.request.getEmail(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: grayColor,
                                fontSize: size.width * 0.04))),
                  ],
                ),
              ),
            ),
            Container(
              width: cardHeight * 0.5,
              height: cardHeight,
              margin: const EdgeInsets.only(left: 5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: greenColor),
              child: InkWell(
                onTap: () async {
                  await handleRequest(context, widget.request.getId(), 'approve');
                  widget.notifyParent();
                },
                child: const Icon(
                  Icons.done_rounded,
                  color: whiteColor,
                ),
              ),
            ),
            //check_circle_rounded cancel_rounded
            Container(
              width: cardHeight * 0.5,
              height: cardHeight,
              margin: const EdgeInsets.only(left: 5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: brightRedColor),
              child: InkWell(
                onTap: () async {
                  await handleRequest(context, widget.request.getId(), 'deny');
                  widget.notifyParent();
                },
                child: const Icon(
                  Icons.clear_rounded,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
