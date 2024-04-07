import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../components/constants.dart';
import '../../../../components/custon_switch.dart';
import '../../../../components/image_constants.dart';
import '../../../../components/widgets/custom_icons.dart';
import '../../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../../models/club_member.dart';
import '../../../../models/enums/member_role.dart';
import '../../../../models/inherited_id.dart';
import '../../../../models/server_exception.dart';

class MemberCard extends StatefulWidget {
  final Function() notifyParent;
  final ClubMember member;
  final int clubId;
  final bool showSwitch;
  final String roleText;

  const MemberCard({
    Key? key,
    required this.notifyParent,
    required this.member,
    required this.showSwitch,
    required this.roleText,
    required this.clubId,
  }) : super(key: key);

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  late int id;

  Future<void> handleRequest(BuildContext context, bool state) async {
    var client = http.Client();
    try {
      final jsonString = json.encode({
        "userId": widget.member.getId(),
        "role": getStringStatForApi(state)
      });
      var response = await client.put(
          Uri.https(url, '/clubs/admin/${widget.clubId}/change-member-role'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'adminId': id.toString(),
          },
          body: jsonString);

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
                'Что-то пошло не так! Не удалось поменять роль пользователя.',
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
                  image: NetworkImage(widget.member.getImageUrl()),
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
                      child: TextScroll(widget.member.getName(),
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
                        child: Text(widget.member.getEmail(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: grayColor,
                                fontSize: size.width * 0.04))),
                  ],
                ),
              ),
            ),
            if (widget.showSwitch)
              CustomLiteRollingSwitch(
                value: widget.member.getHasAdminRules(),
                width: 65,
                textOff: '',
                textOn: '',
                colorOn: secondaryColor,
                colorOff: secondaryColor,
                iconOn: CustomIcons.crown,
                iconOff: CustomIcons.crown,
                animationDuration: const Duration(milliseconds: 100),
                onChanged: (bool state) async {
                  await handleRequest(context, state);
                  widget.notifyParent();
                },
                onDoubleTap: () {},
                onSwipe: () {},
                onTap: () {},
                circleColorOn: primaryColor,
                circleColorOff: const Color(0xFFB1B2BB),
              ),
            if (!widget.showSwitch)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.roleText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: darkGrayColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
