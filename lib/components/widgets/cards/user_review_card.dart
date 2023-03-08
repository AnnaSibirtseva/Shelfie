import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

import '../../../models/book_Review.dart';
import '../../../models/user_review.dart';
import '../dialogs/confirmation_dialog.dart';

class UserReviewCard extends StatefulWidget {
  final UserReview review;

  const UserReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  _UserReviewCardState createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  //final VoidCallback press;
  late UserReview review;

  @override
  void initState() {
    review = widget.review;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dismissible(
      key: Key(review.getReviewText()),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmationDialog(
                text: 'Вы действительно хотите удалить эту рецензию?');
          },
        );
      },
      background: deleteBackGroundItem(),
      child: Container(
        width: size.width,
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
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width * 0.12,
                  height: size.height * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color:primaryColor),
                    image: DecorationImage(
                      image: NetworkImage(review.getReviewImg()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"' + review.getTitle() + '"',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: size.width / 24,  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          review.getAuthors(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: size.width / 27,  fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      color: primaryColor,
                      size: 30,
                    ),
                    Text(
                      review.getReviewRating().toString(),
                      style: const TextStyle(
                        fontSize: 18,
                          fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ],
                )
              ],
            ),
           // const Divider(color: Colors.white70,),
            const SizedBox(height: 15),
            Text(
              review.getReviewText(),
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: size.width / 24, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteBackGroundItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: Color(0xFFE57373),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

}