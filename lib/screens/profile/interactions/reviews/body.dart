import 'package:flutter/material.dart';

import '../../../../components/widgets/cards/user_review_card.dart';
import '../../../../models/user_review.dart';
import '../header_widget.dart';

class Body extends StatelessWidget {
  final List<UserReview> reviews;

  const Body({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: 15, right: 15, top: 15, bottom: size.height * 0.1),
      height: size.height - size.height * 0.1,
      width: size.width,
      child: SingleChildScrollView(
        reverse: false,
        child: Column(
          children: [
            const HeaderWidget(
              text: 'Рецензии',
              icon: 'review',
            ),
            for (UserReview review in reviews)
              UserReviewCard(
                review: review,
              ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
