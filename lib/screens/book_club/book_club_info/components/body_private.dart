import 'package:flutter/material.dart';
import '../../../../components/constants.dart';
import '../../../../components/image_constants.dart';

class PrivateBody extends StatelessWidget {
  const PrivateBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Image.network(
            privateClub,
            height: 180,
            width: 180,
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Это приватный клуб.\nСтаньте его участником, чтобы видеть события",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                  color: blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
