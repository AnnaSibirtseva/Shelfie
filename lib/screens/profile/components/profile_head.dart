import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/models/inherited_id.dart';
import 'package:shelfie/models/user.dart';

import '../../../components/widgets/dialogs/change_banner_dialog.dart';

class ProfileHead extends StatefulWidget {
  final User user;

  const ProfileHead({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileHead createState() => _ProfileHead();
}

class _ProfileHead extends State<ProfileHead> {
  late int id;
  late ChangeBannerDialog dialog;

  FutureOr changePic(dynamic value) {
    widget.user.setBanner(dialog.getAvatar());
    setState(() {
    });
  }

  void showChangeAvatarDialog() {
    dialog = ChangeBannerDialog(id);
    showDialog(
        context: context,
        builder: (BuildContext context) => dialog).then(changePic);
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
            onTap: showChangeAvatarDialog,
            child: Container(
              height: size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: NetworkImage(user.getBannerImageUrl()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              right: size.height * 0.3,
              left: 0.0,
              bottom: 0.0,
              child: Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: secondaryColor),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.getProfileImageUrl()),
                    fit: BoxFit.cover,
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
