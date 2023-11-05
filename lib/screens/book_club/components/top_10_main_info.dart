import 'package:flutter/material.dart';
import '../../../../components/constants.dart';
import '../../../models/book.dart';

class Top10MainInfo extends StatelessWidget {
  final Book book;

  const Top10MainInfo({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * 0.3,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  for (String author in book.getAuthors())
                    Text(author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [ratingWidget()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        Text('$rating/10',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
      ],
    );
  }
}
