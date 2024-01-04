import 'package:flutter/material.dart';

import '../../../models/book_club.dart';
import '../../../screens/book_club/components/club_name_widget.dart';
import '../../constants.dart';

class SearchBookClubCard extends StatelessWidget {
  final VoidCallback press;
  final BookClub bookClub;

  const SearchBookClubCard({
    Key? key,
    required this.press,
    required this.bookClub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardHeight = size.height * 0.15;
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
        height: cardHeight,
        width: size.width,
        child: Row(
          children: [
            Container(
              width: cardHeight,
              height: cardHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(bookClub.getCoverImgUrl()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClubNameWithPrivacyName(
                      isPublic: bookClub.isPublic(),
                      fontSize: 18.0,
                      clubName: bookClub.getName(),
                    ),
                    Text(
                        bookClub.getDescription() == null
                            ? "-"
                            : bookClub.getDescription()!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12.0)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: membersWidget(bookClub.isUserInClub())),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget membersWidget(bool isMember) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.person_rounded,
          color: isMember ? primaryColor : grayColor,
          size: 20,
        ),
        const SizedBox(width: 5),
        // Flexible(child:
        Text('${bookClub.getMembersCount()} участников',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: isMember ? primaryColor : grayColor)),
        //),
        const Spacer(),
        if (isMember)
          const Icon(
            Icons.check_rounded,
            color: primaryColor,
            size: 20,
          ),
      ],
    );
  }
}
