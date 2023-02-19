import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:shelfie/components/widgets/status.dart';
import 'package:shelfie/models/book_status.dart';
import 'package:shelfie/models/user.dart';

class BookMainInfo extends StatefulWidget {
  const BookMainInfo({Key? key}) : super(key: key);

  @override
  _BookMainInfo createState() => _BookMainInfo();
}

class _BookMainInfo extends State<BookMainInfo> {
  // todo: change to gesture detectors and add photo-changers.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //User user = widget.user;

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
                      'https://i.artfile.ru/2595x1730_930608_[www.ArtFile.ru].jpg'),
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
                          child: Text('Длинноооое Название',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                        ),
                        ratingWidget(3)
                      ],
                    ),
                    Text(
                        // todo do sth with no authors or more than 1.
                        'А. Б. Авторов',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0)),
                    const SizedBox(height: 5),
                    Flexible(
                      child: tenStarWidget(5.1),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      runSpacing: 5,
                      children: [
                        infoText('Язык оригинала:'),
                        infoText('Возрастные ограничения: '),
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            infoText('Жанры:'),
                            genreWidget('Лучший'),
                            genreWidget('Фантастика'),
                            genreWidget('Роман'),
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

  Widget tenStarWidget(double rating) {
    return Wrap(
      spacing: 0.005,
      children: [
        for (int i = 0; i <= rating; ++i) starIcon(true),
        for (int i = rating.round(); i < 10; ++i) starIcon(false),
        // Text(rating.toString() + '/10',
        //     textAlign: TextAlign.start,
        //     style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold))
      ],
    );
  }

  //Expanded(
  //                       child: Align(
  //                         alignment: Alignment.bottomLeft,
  //                         child: Row(
  //                           children: [
  //                             StatusWidget(bookState: BookStatus.Planning),
  //                           ],
  //                         ),
  //                       ),
  //                     ),

  GestureDetector starIcon(bool filled) {
    return GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.star_rounded,
          color: filled ? Colors.amber : Colors.black12,
          size: 18,
        ));
  }

  Widget ratingWidget(double rating) {
    return Row(
      children: [
        const Icon(
          Icons.star_border_rounded,
          color: primaryColor,
          size: 30,
        ),
        Text(rating.toString(),
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
