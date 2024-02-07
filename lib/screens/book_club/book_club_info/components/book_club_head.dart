import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../components/constants.dart';
import '../../../../components/image_constants.dart';
import '../../../../models/book_club.dart';
import '../../../../models/inherited_id.dart';
import '../../components/club_name_widget.dart';

class BookClubHead extends StatefulWidget {
  final BookClub bookClub;

  const BookClubHead({Key? key, required this.bookClub}) : super(key: key);

  @override
  _ProfileHead createState() => _ProfileHead();
}

class _ProfileHead extends State<BookClubHead> {
  late int id;

  // late ChangeBannerDialog banDialog;
  // late ChangeAvatarDialog avDialog;
  //
  // FutureOr changeBanner(dynamic value) {
  //   widget.bookClub.setBanner(banDialog.getAvatar());
  //   setState(() {});
  // }
  //
  // FutureOr changeAvatar(dynamic value) {
  //   widget.bookClub.setAvatar(avDialog.getAvatar());
  //   setState(() {});
  // }
  //
  // void showChangeBannerDialog() {
  //   banDialog = ChangeBannerDialog(id);
  //   showDialog(context: context, builder: (BuildContext context) => banDialog)
  //       .then(changeBanner);
  // }
  //
  // void showChangeAvatarDialog() {
  //   avDialog = ChangeAvatarDialog(id);
  //   showDialog(context: context, builder: (BuildContext context) => avDialog)
  //       .then(changeAvatar);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BookClub bookClub = widget.bookClub;
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return Flexible(
        child: SizedBox(
      height: size.height * 0.3,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => {},
            child: Container(
              height: size.height * 0.3,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.22,
                    decoration: BoxDecoration(
                      border: Border.all(color: secondaryColor),
                      image: const DecorationImage(
                        image: NetworkImage(wrongLongImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(bookClub.getBannerImgUrl()),
                        onError: (error, stackTrace) =>
                            const NetworkImage(defaultCollectionImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Theme.of(context).scaffoldBackgroundColor)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: 0,
              left: 0.0,
              bottom: 0.0,
              top: size.height * 0.11,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 10),
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: secondaryColor),
                        image: const DecorationImage(
                          image: NetworkImage(wrongCircleImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(color: secondaryColor),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://yt3.googleusercontent.com/ytc/APkrFKbTPLpiVMOCrpT-ZtOdECDVBvYXuJLK9PS0jBj2=s900-c-k-c0x00ffffff-no-rj"),
                          onError: (error, stackTrace) =>
                              const NetworkImage(defaultCollectionImg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.1 + 5),
                          ClubNameWithPrivacyName(
                            isPublic: bookClub.isPublic(),
                            fontSize: size.width * 0.05,
                            clubName: bookClub.getName(),
                            isBold: true,
                            isUserAdminInClub: bookClub.getIsUserAdminInClub(),
                            clubId: bookClub.getId(),
                          ),

                          const SizedBox(height: 3),
                          membersWidget()
                        ]),
                  )
                ],
              ))
        ],
      ),
    ));
  }

  Widget membersWidget() {
    int membersAmount = widget.bookClub.getMembersCount();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.person_rounded,
          size: 20,
        ),
        const SizedBox(width: 5),
        // Flexible(child:
        Text('$membersAmount ${_parseMembersWord(membersAmount)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            )),
        if (widget.bookClub.getIsUserAdminInClub())
        const Align(
          alignment: Alignment.bottomRight,
          child: Icon(
            Icons.circle,
            color: redColor,
            size: 7,
          ),
        ),
        //),
      ],
    );
  }

  String _parseMembersWord(int amount) {
    String ending = "";
    int lastDigit = amount % 10;
    if ([2, 3, 4].contains(lastDigit)) {
      ending = "а";
    } else if ([0, 5, 6, 7, 8, 9].contains(lastDigit)) {
      ending = "ов";
    }

    return "участник" + ending;
  }
}
