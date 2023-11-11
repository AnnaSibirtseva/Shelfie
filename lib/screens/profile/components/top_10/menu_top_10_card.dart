import 'package:flutter/material.dart';

import '../../../../components/image_constants.dart';
import '../../../../components/constants.dart';

class MenuTop10Card extends StatelessWidget {
  final VoidCallback press;

  const MenuTop10Card({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Container(
        height: size.height * 0.1,
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(top10Background),
              fit: BoxFit.cover,
              opacity: 0.7
            ),
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Мой ТОП-10",
                style: TextStyle(
                    fontSize: size.width * 0.075, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
