import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../models/top-10_book.dart';
import '../../constants.dart';

class Top10CardLight extends StatefulWidget {
  late List<Top10BookInfo> books;
  final Top10BookInfo newBook;

  Top10CardLight({super.key, required this.books, required this.newBook});

  @override
  State<Top10CardLight> createState() => _Top10CardLightState();

  List<Top10BookInfo> getBooks(){
    return books;
  }
}

class _Top10CardLightState extends State<Top10CardLight> {
  late final List<Top10BookInfo> _items;

  @override
  void initState() {
    _items = widget.books;
    var newBook = widget.newBook;
    if (!_items.contains(newBook)) {
      _items.add(newBook);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Card> cards = <Card>[
      for (int index = 0; index < _items.length; index += 1)
        Card(
            key: Key('$index'),
            color: index >= 10 ? lightGrayColor : secondaryColor,
            child: Opacity(
              opacity: index >= 10 ? 0.6 : 1,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 5, top: 5, bottom: 5),
                height: size.height * 0.095,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${index + 1}.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: index >= 10 ? grayColor : primaryColor,
                          fontSize: size.width / 23,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: size.width * 0.12,
                      height: size.height * 0.085,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: index >= 10 ? grayColor : primaryColor),
                        image: DecorationImage(
                          image: NetworkImage(_items[index].getImageUrl()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"${_items[index].getTitle()}"',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: size.width / 24,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${_items[index].getAuthors()}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: size.width / 27,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            )),
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(1, 6, animValue)!;
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            // Create a Card based on the color and the content of the dragged one
            // and set its elevation to the animated value.
            child: Card(
              elevation: elevation,
              color: cards[index].color,
              child: cards[index].child,
            ),
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      proxyDecorator: proxyDecorator,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Top10BookInfo item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
          widget.books = _items;
        });
      },
      children: cards,
    );
  }
}
