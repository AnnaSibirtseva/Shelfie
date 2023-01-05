import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../components/constants.dart';

class ListBookCard extends StatelessWidget {
  final VoidCallback press;

  const ListBookCard({
    Key? key,
    required this.press,
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
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://funart.pro/uploads/posts/2021-07/1626892739_41-funart-pro-p-koshka-v-ochkakh-zhivotnie-krasivo-foto-63.jpg'),
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
                      Text('Заголовок типа',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      Text('А.Б. Авторов',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16.0)),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          // Лучшие среди самых лучших фантастик 2022
                          genreWidget('Фантастика'),
                          genreWidget('Еще жанр'),
                          genreWidget(
                              'Лучшие среди самых лучших фантастик 2022'),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              ratingWidget(),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    print('ONE');
                                  },
                                  onDoubleTap: () {
                                    print('TWO');
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline_rounded,
                                    color: primaryColor,
                                    size: 40,
                                  ),
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
    return Row(
      children: const [
        Icon(
          Icons.star_border_rounded,
          color: primaryColor,
          size: 30,
        ),
        Text('8.9' + '/10',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
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
