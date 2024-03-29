import 'package:flutter/material.dart';
import '../../../../components/widgets/genre_widget.dart';
import '../../../../components/widgets/dialogs/change_top_10.dart';
import '../../../../models/inherited_id.dart';

import '../../../../components/constants.dart';
import '../../../../models/book.dart';
import '../../../../models/top-10_book.dart';

class BookMainInfo extends StatefulWidget {
  final Book book;

  const BookMainInfo({Key? key, required this.book}) : super(key: key);

  @override
  _BookMainInfo createState() => _BookMainInfo();
}

class _BookMainInfo extends State<BookMainInfo> {
  @override
  Widget build(BuildContext context) {
    final inheritedWidget = IdInheritedWidget.of(context);
    Size size = MediaQuery.of(context).size;
    Book book = widget.book;

    return Container(
        margin: EdgeInsets.only(bottom: size.height * 0.01),
        padding: const EdgeInsets.all(5),
        height: size.height * 0.3,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                InkWell(
                  onTap: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChangeTop10Dialog(
                            inheritedWidget.id,
                            Top10BookInfo.light(
                                book.getId(),
                                book.getTitle(),
                                book.getImageUrl(),
                                book.getAuthors().isEmpty
                                    ? ""
                                    : book.getAuthors().first),
                          );
                        })
                  },
                  child: Container(
                    width: size.width * 0.1,
                    height: size.width * 0.1,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: secondaryColor),
                    child: const Icon(
                      Icons.stars_rounded,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: false,
                child: Container(
                  width: size.width * 0.5,
                  //height: size.height * 0.4,
                  padding: const EdgeInsets.only(left: 15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Text(book.getTitle(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                          ),
                          ratingWidget(book.getRating())
                        ],
                      ),
                      //for (int i = 0; i < book.getAuthors().length; i++)
                      Text(book.getAuthors().join(', '),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16.0)),
                      const SizedBox(height: 5),
                      Flexible(
                        child: Wrap(
                          runSpacing: 5,
                          children: [
                            tenStarWidget(book.getUserRating() == null
                                ? 0
                                : book.getUserRating()!),
                            infoText('Язык оригинала: ' +
                                (book.getLanguage() == null
                                    ? '-'
                                    : book.getLanguage()!)),
                            infoText('Возрастные ограничения: ' +
                                (book.getAgeRest() == null
                                    ? 'нет'
                                    : book.getAgeRest()!)),
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                infoText('Жанры:' +
                                    (book.getGenreList().genres.isEmpty
                                        ? 'нет'
                                        : '')),
                                for (int i = 0;
                                    i < book.getGenreList().genres.length;
                                    ++i)
                                  GenreWidget(
                                      genreName: book
                                          .getGenreList()
                                          .genres[i]
                                          .getGenreName()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 0.005,
        children: [
          for (int i = 0; i < rating; ++i) starIcon(true),
          for (int i = rating.round(); i < 10; ++i) starIcon(false),
        ],
      ),
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
}
