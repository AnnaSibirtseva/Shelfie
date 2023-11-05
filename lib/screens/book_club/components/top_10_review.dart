import 'package:flutter/material.dart';

import '../../../components/constants.dart';
import '../../../models/inherited_id.dart';
import '../../../models/user_review.dart';

class Top10ReviewCard extends StatefulWidget {
  final UserReview review;

  const Top10ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  _Top10ReviewCard createState() => _Top10ReviewCard();
}

class _Top10ReviewCard extends State<Top10ReviewCard> {
  late UserReview review;
  bool showFlag = false;

  @override
  void initState() {
    review = widget.review;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String revText = review.getReviewText();
    Size size = MediaQuery.of(context).size;
    final inheritedWidget = IdInheritedWidget.of(context);
    return Container(
        width: size.width,
        decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.getReviewTitle(),
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: size.width / 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                revText,
                textAlign: TextAlign.justify,
                maxLines: showFlag ? 15 : 7,
                style: TextStyle(
                    fontSize: size.width / 26, fontWeight: FontWeight.normal),
              ),
              if (revText.isNotEmpty && revText.length > 250)
                InkWell(
                  onTap: () {
                    setState(() {
                      showFlag = !showFlag;
                    });
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(showFlag ? "Свернуть" : "Развернуть",
                              style: const TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                ),
            ]));
  }

  Widget deleteBackGroundItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: redColor, borderRadius: BorderRadius.all(Radius.circular(15))),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(
        Icons.delete,
        color: whiteColor,
      ),
    );
  }
}
