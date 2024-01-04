import 'package:flutter/material.dart';

class ClubNameWithPrivacyName extends StatelessWidget {
  final bool isPublic;
  final String clubName;
  final double fontSize;

  const ClubNameWithPrivacyName(
      {super.key,
      required this.isPublic,
      required this.fontSize,
      required this.clubName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isPublic)
          Icon(
            Icons.lock_rounded,
            size: fontSize ,
          ),
        if (!isPublic) const SizedBox(width: 5),
        Flexible(child: Text(clubName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize))),
      ],
    );
  }
}
