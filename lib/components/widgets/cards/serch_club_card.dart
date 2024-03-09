import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';

import '../../../models/book_club.dart';
import '../../../screens/book_club/components/club_name_widget.dart';
import '../../constants.dart';
import '../../image_constants.dart';
import '../genre_widget.dart';

class SearchBookClubCard extends StatefulWidget {
  final VoidCallback press;
  final BookClub bookClub;

  const SearchBookClubCard({
    Key? key,
    required this.press,
    required this.bookClub,
  }) : super(key: key);

  @override
  State<SearchBookClubCard> createState() => _SearchBookClubCardState();
}

class _SearchBookClubCardState extends State<SearchBookClubCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardHeight = size.height * 0.15;
    return InkWell(
      onTap: widget.press,
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
                  image: NetworkImage(widget.bookClub.getCoverImgUrl()),
                  onError: (error, stackTrace) =>
                      const NetworkImage(defaultCollectionImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClubNameWithPrivacyName(
                      isPublic: widget.bookClub.isPublic(),
                      fontSize: 18.0,
                      clubName: widget.bookClub.getName(),
                      isBold: false,
                      isUserAdminInClub: false,
                      club: widget.bookClub,
                    ),
                    const SizedBox(height: 5),
                    ExtendedWrap(
                      maxLines: 2,
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (int i = 0;
                            i <
                                widget.bookClub
                                    .getClubTags()
                                    .tags
                                    .take(3)
                                    .length;
                            ++i)
                          GenreWidget(
                            genreName: widget.bookClub
                                .getClubTags()
                                .tags[i]
                                .getTagName(),
                          )
                      ],
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: membersWidget(widget.bookClub.isUserInClub())),
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
        Text('${widget.bookClub.getMembersCount()} участников',
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
