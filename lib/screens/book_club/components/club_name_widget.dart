import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shelfie_diploma_app/components/constants.dart';

import '../../../components/image_constants.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/dialogs/change_book_club_info_dialog.dart';
import '../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../models/inherited_id.dart';

class ClubNameWithPrivacyName extends StatefulWidget {
  final bool isPublic;
  final int clubId;
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
      required this.clubId});

  @override
  State<ClubNameWithPrivacyName> createState() =>
      _ClubNameWithPrivacyNameState();
}

class _ClubNameWithPrivacyNameState extends State<ClubNameWithPrivacyName> {
  FutureOr onGoBack(dynamic value) {
    context.router.pop();
    context.router.push(BookClubInfoRoute(bookId: widget.clubId));
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
            child: Text(widget.clubName.replaceAll("", "\u{200B}"),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight:
                        widget.isBold ? FontWeight.w900 : FontWeight.bold,
                    fontSize: widget.fontSize))),
        //if (isUserAdminInClub) const Spacer(),
        if (widget.isUserAdminInClub)
          InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => Center(
                            child: ChangeClubInfoDialog(
                          userId: inheritedWidget.id,
                          clubId: widget.clubId,
                        ))).then(onGoBack);
              },
              child: Icon(
                Icons.settings_rounded,
                color: primaryColor,
                size: widget.fontSize,
              )),
        if (widget.isUserAdminInClub) const SizedBox(width: 15),
      ],
    );
  }
}
