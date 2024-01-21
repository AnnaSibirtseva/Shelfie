import 'package:flutter/material.dart';
import 'package:shelfie_diploma_app/components/constants.dart';

class ClubNameWithPrivacyName extends StatelessWidget {
  final bool isPublic;
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
      required this.isUserAdminInClub});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (!isPublic)
          Icon(
            Icons.lock_rounded,
            size: fontSize,
          ),
        if (!isPublic) const SizedBox(width: 5),
        Expanded(
            child: Text(clubName.replaceAll("", "\u{200B}"),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
                    fontSize: fontSize))),
        //if (isUserAdminInClub) const Spacer(),
        if (isUserAdminInClub)
          Icon(
            Icons.settings_rounded,
            color: primaryColor,
            size: fontSize,
          ),
        if (isUserAdminInClub) const SizedBox(width: 15),
      ],
    );
  }
}
