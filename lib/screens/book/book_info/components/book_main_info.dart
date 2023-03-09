import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/status.dart';
import 'package:shelfie/models/book_status.dart';
import 'package:shelfie/models/user.dart';

import '../../../../models/book.dart';

class BookMainInfo extends StatefulWidget {
  final Book book;

  const BookMainInfo({Key? key, required this.book}) : super(key: key);

  @override
  _BookMainInfo createState() => _BookMainInfo();
}

class _BookMainInfo extends State<BookMainInfo> {
  // todo: change to gesture detectors and add photo-changers.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Book book = widget.book;

    return Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        padding: const EdgeInsets.all(5),
        height: size.height * 0.3,
        width: size.width,
        child: Row(
          children: [
            Container(
              width: size.width * 0.35,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: NetworkImage(
                      book.getImageUrl()),
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(book.getTitle(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                        ),
                        ratingWidget(book.getRating())
                      ],
                    ),
                    for (int i = 0; i < book.getAuthors().length; i++)
                    Text(
                        // todo do sth with no authors or more than 1.
                        book.getAuthors()[i],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0)),
                    const SizedBox(height: 5),
                    Flexible(
                      child: tenStarWidget(book.getUserRating() == null ? 0 : book.getUserRating()!),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      runSpacing: 5,
                      children: [
                        infoText('Язык оригинала: ' + (book.getLanguage() == null ? '-' : book.getLanguage()!)),
                        infoText('Возрастные ограничения: ' + (book.getAgeRest() == null ? '-' : book.getAgeRest()!)),
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            infoText('Жанры:'),
                            for (int i = 0; i < book.getGenreList().genres.length; ++i)
                              genreWidget(book.getGenreList().genres[i].getGenreName()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Text infoText(String text) {
    return Text(text, style: const TextStyle(fontSize: 12.0));
  }

  Widget tenStarWidget(int rating) {
    return Wrap(
      spacing: 0.005,
      children: [
        for (int i = 0; i < rating; ++i) starIcon(true),
        for (int i = rating.round(); i < 10; ++i) starIcon(false),
      ],
    );
  }

  GestureDetector starIcon(bool filled) {
    return GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.star_rounded,
          color: filled ? Colors.amber : Colors.black12,
          size: 18,
        ));
  }

  Widget ratingWidget(double? rating) {
    return Row(
      children: [
        const Icon(
          Icons.star_border_rounded,
          color: primaryColor,
          size: 30,
        ),
        Text(rating == null ? '-' : rating.toString(),
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget genreWidget(String genre) {
    return Container(
      height: 20,
      //margin: const EdgeInsets.only(top: 10, right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(genre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0)),
    );
  }
}
