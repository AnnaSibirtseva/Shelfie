import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

import '../../../models/book_review.dart';

class ReviewCard extends StatelessWidget {
  //final VoidCallback press;
  final BookReview review;

  const ReviewCard({
    Key? key,
    required this.review,
    //required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                              review.getReviewAuthor().getProfileImageUrl(),
                            ),
                            maxRadius: 25,
                          )),
                      const SizedBox(width: 15),
                      Expanded(
                          child: Text(
                        review.getReviewAuthor().getName(),
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
                      review.getReviewRating().toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              review.getReviewText(),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
