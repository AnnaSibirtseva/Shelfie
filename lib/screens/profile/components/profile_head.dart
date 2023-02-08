import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/models/user.dart';

import '../profile_page.dart';

class ProfileHead extends StatefulWidget {

  const ProfileHead({Key? key}) : super(key: key);

  @override
  _ProfileHead createState() => _ProfileHead();
}

class _ProfileHead extends State<ProfileHead> {
  // todo: change to gesture detectors and add photo-changers.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Flexible(
        child: SizedBox(
      height: size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(
                  user.getProfileImageUrl()),
                fit: BoxFit.cover,
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
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        user.getProfileImageUrl()),
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
