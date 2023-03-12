import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

import '../../../models/book_review.dart';

class ReviewCard extends StatefulWidget {
  //final VoidCallback press;
  final BookReview review;

  const ReviewCard({
    Key? key,
    required this.review,
    //required this.press,
  }) : super(key: key);

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool showFlag = false;

  @override
  Widget build(BuildContext context) {
    String revText = widget.review.getReviewText();
    Size size = MediaQuery.of(context).size;
    return InkWell(
      //onTap: press,
      child: Container(
        decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                          radius: 27,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.review
                                  .getReviewAuthor()
                                  .getProfileImageUrl(),
                            ),
                            maxRadius: 25,
                          )),
                      const SizedBox(width: 15),
                      Expanded(
                          child: Text(
                        widget.review.getReviewAuthor().getName(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      color: primaryColor,
                      size: 25,
                    ),
                    Text(
                      widget.review.getReviewRating().toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 5),
            //const Divider(color: primaryColor, thickness: 1.5),
            Text(
              widget.review.getReviewTitle(),
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: size.width / 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              widget.review.getReviewText(),
              textAlign: TextAlign.justify,
              maxLines: showFlag ? null : 7,
              style: TextStyle(
                  fontSize: size.width / 28, fontWeight: FontWeight.normal),
            ),
            if (revText != '-' && revText.isNotEmpty)
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
                  )),
          ],
        ),
      ),
    );
  }
}
