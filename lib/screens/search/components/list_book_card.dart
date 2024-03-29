import 'package:flutter/material.dart';

import '../../../components/constants.dart';
import '../../../components/widgets/genre_widget.dart';
import '../../../components/widgets/status.dart';
import '../../../models/book.dart';

class ListBookCard extends StatelessWidget {
  final VoidCallback press;
  final Book book;

  const ListBookCard({
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width / 21)),
                    for (String author in book.getAuthors().take(2))
                      Text(author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: size.width / 23)),
                    if (book.getAuthors().length > 2)
                      const Text('и другие',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: grayColor, fontSize: 13.0)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (int i = 0;
                            i < book.getGenreList().genres.take(3).length;
                            ++i)
                          GenreWidget(
                            genreName:
                                book.getGenreList().genres[i].getGenreName(),
                          )
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            ratingWidget(),
                            const Spacer(),
                            StatusWidget(
                              bookState: book.getStatus(),
                              bookId: book.getId(),
                            ),
                          ],
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
    String rating =
        book.getRating() == null ? '-' : book.getRating().toString();
    return Row(
      children: [
        const Icon(
          Icons.star_border_rounded,
          color: primaryColor,
          size: 30,
        ),
        Text(rating + '/10',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
      ],
    );
  }
}
