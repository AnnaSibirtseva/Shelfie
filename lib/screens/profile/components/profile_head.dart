import 'dart:async';

import 'package:flutter/material.dart';

import '../../../components/constants.dart';
import '../../../components/image_constants.dart';
import '../../../components/widgets/dialogs/change_avatar_dialog.dart';
import '../../../components/widgets/dialogs/change_banner_dialog.dart';
import '../../../models/inherited_id.dart';
import '../../../models/user.dart';

class ProfileHead extends StatefulWidget {
  final User user;

  const ProfileHead({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileHead createState() => _ProfileHead();
}

class _ProfileHead extends State<ProfileHead> {
  late int id;
  late ChangeBannerDialog banDialog;
  late ChangeAvatarDialog avDialog;

  FutureOr changeBanner(dynamic value) {
    widget.user.setBanner(banDialog.getAvatar());
    setState(() {});
  }

  FutureOr changeAvatar(dynamic value) {
    widget.user.setAvatar(avDialog.getAvatar());
    setState(() {});
  }

  void showChangeBannerDialog() {
    banDialog = ChangeBannerDialog(id);
    showDialog(context: context, builder: (BuildContext context) => banDialog)
        .then(changeBanner);
  }

  void showChangeAvatarDialog() {
    avDialog = ChangeAvatarDialog(id);
    showDialog(context: context, builder: (BuildContext context) => avDialog)
        .then(changeAvatar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User user = widget.user;
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return Flexible(
        child: SizedBox(
      height: size.height * 0.3,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: showChangeBannerDialog,
            child: Container(
              height: size.height * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: secondaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: const DecorationImage(
                  image: NetworkImage(wrongLongImage),
                  fit: BoxFit.cover,
                ),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: NetworkImage(user.getBannerImageUrl()),
                  onError: (error, stackTrace) =>
                  const NetworkImage(defaultCollectionImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              right: size.height * 0.3,
              left: 0.0,
              bottom: 0.0,
              child: GestureDetector(
                onTap: showChangeAvatarDialog,
                child: Container(
                  height: size.height * 0.2,
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
                      image: NetworkImage(user.getProfileImageUrl()),
                      onError: (error, stackTrace) =>
                          const NetworkImage(defaultCollectionImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Row(
                children: [
                  SizedBox(
                    width: size.height * 0.2,
                  ),
                  Flexible(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          Text(
                            user.getName(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'VelaSansExtraBold',
                                //color: Colors.black,
                                fontSize: size.width * 0.055,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            user.getEmail(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: grayColor,
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w700),
                          ),
                        ]),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
