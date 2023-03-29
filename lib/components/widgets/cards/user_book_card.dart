import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/models/user_book.dart';

class UserBookCard extends StatelessWidget {
  final VoidCallback press;
  final UserBook book;

  const UserBookCard({
    Key? key,
    required this.press,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.05),
        padding: const EdgeInsets.all(5),
        height: size.height * 0.3,
        width: size.width * 0.9,
        child: Row(
          children: [
            Container(
              width: size.width * 0.35,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: NetworkImage(book.getImageUrl()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(book.getTitle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0)),
                    for (String author in book.getAuthors())
                      Text(author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16.0)),
                    const SizedBox(height: 10),
                    ratingWidget(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [timeWidget(size)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingWidget() {
    bool hasRating = book.getUserRating() != null;
    String rating = hasRating ? book.getUserRating().toString() : '-';
    return Row(
      children: [
        Icon(
          Icons.star_rate_rounded,
          color: hasRating ? primaryColor : grayColor,
          size: 30,
        ),
        Text(rating + '/10',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget timeWidget(Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Начало: ' + book.getStartTime(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: size.width * 0.035)),
        Text('Конец: ' + book.getEndTime(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: size.width * 0.035)),
      ],
    );
  }
}
