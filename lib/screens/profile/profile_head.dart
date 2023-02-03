import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class ProfileHead extends StatefulWidget {
  //final User user;

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
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.goodmorningimagesforlover.com/wp-content/uploads/2018/11/create-facebook-cover-photo-for-whatsapp.jpg'),
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
                        'https://im.wampi.ru/2023/01/26/image736cca3df952241c.png'),
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
                            'Джейк Хэйлл',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'VelaSansExtraBold',
                                //color: Colors.black,
                                fontSize: size.width * 0.055,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'jake.hayle@goоgle.com',
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
