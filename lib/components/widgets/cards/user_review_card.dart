import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

import '../../../models/user_review.dart';
import 'package:auto_route/auto_route.dart';
import '../dialogs/confirmation_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie/models/inherited_id.dart';
import 'dart:convert';
import 'dart:io';

class UserReviewCard extends StatefulWidget {
  final UserReview review;

  const UserReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  _UserReviewCardState createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  //final VoidCallback press;
  late UserReview review;
  bool showFlag = false;

  @override
  void initState() {
    review = widget.review;
    super.initState();
  }

  Future<void> deleteReview(int id) async {
    var client = http.Client();
    final jsonString = json.encode({});
    try {
      var response = await client.delete(
          Uri.https(url, '/interactions/reviews/${review.getId()}/remove'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          },
          body: jsonString);
      if (response.statusCode != 200) {
        //TODO: show message
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    String revText = review.getReviewText();
    Size size = MediaQuery.of(context).size;
    final inheritedWidget = IdInheritedWidget.of(context);
    return Dismissible(
      key: Key(review.getId().toString()),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              text: 'Вы действительно хотите удалить эту рецензию?',
              press: () async {
                await deleteReview(inheritedWidget.id);
                context.router.pop(true);
              },
            );
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
                    border: Border.all(color: primaryColor),
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
                      style: TextStyle(
                          fontSize: size.width / 24,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      review.getAuthors(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: size.width / 27,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                )),
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
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ],
                )
              ],
            ),
            // const Divider(color: Colors.white70,),
            const SizedBox(height: 15),
            Text(
              review.getReviewTitle(),
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: size.width / 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              revText,
              textAlign: TextAlign.justify,
              maxLines: showFlag ? null : 7,
              style: TextStyle(
                  fontSize: size.width / 24, fontWeight: FontWeight.normal),
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
