import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shelfie_diploma_app/components/constants.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/dialogs/change_book_club_info_dialog.dart';
import '../../../models/book_club.dart';
import '../../../models/inherited_id.dart';

class ClubNameWithPrivacyName extends StatefulWidget {
  final bool isPublic;
  final BookClub club;
  final String clubName;
  final double fontSize;
  final bool isBold;
  final bool isUserAdminInClub;

  const ClubNameWithPrivacyName(
      {super.key,
      required this.isPublic,
      required this.fontSize,
      required this.clubName,
      required this.isBold,
      required this.isUserAdminInClub,
      required this.club});

  @override
  State<ClubNameWithPrivacyName> createState() =>
      _ClubNameWithPrivacyNameState();
}

class _ClubNameWithPrivacyNameState extends State<ClubNameWithPrivacyName> {
  FutureOr onGoBack(dynamic value) {
    context.router.pop();
    context.router.push(BookClubInfoRoute(bookId: widget.club.getId()));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (!widget.isPublic)
          Icon(
            Icons.lock_rounded,
            size: widget.fontSize,
          ),
        if (!widget.isPublic) const SizedBox(width: 5),
        Expanded(
          child: TextScroll(widget.clubName,
              intervalSpaces: 5,
              velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
              fadedBorder: true,
              fadeBorderVisibility: FadeBorderVisibility.auto,
              fadeBorderSide: FadeBorderSide.right,
              style: TextStyle(
                  fontWeight: widget.isBold ? FontWeight.w900 : FontWeight.bold,
                  fontSize: widget.fontSize)),
          // Text(widget.clubName.replaceAll("", "\u{200B}"),
          //     softWrap: false,
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //         fontWeight:
          //             widget.isBold ? FontWeight.w900 : FontWeight.bold,
          //         fontSize: widget.fontSize))
        ),
        //if (isUserAdminInClub) const Spacer(),
        if (widget.isUserAdminInClub)
          InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => Center(
                            child: ChangeClubInfoDialog(
                          userId: inheritedWidget.id,
                          club: widget.club,
                        ))).then(onGoBack);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.settings_rounded,
                  color: primaryColor,
                  size: widget.fontSize,
                ),
              )),
        if (widget.isUserAdminInClub) const SizedBox(width: 15),
      ],
    );
  }
}
