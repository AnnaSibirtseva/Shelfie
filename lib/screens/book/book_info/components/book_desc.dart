import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';

class BookDesc extends StatefulWidget {
  final String desc;
  const BookDesc({Key? key, required this.desc}) : super(key: key);

  @override
  _BookDescState createState() => _BookDescState();
}

class _BookDescState extends State<BookDesc> {
  bool descTextShowFlag = false;
  late String descText;

  @override
  void initState() {
    super.initState();
    descText = widget.desc;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      //height: descTextShowFlag ? size.height * 0.37 : size.height * 0.25,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Описание',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(descText,
              textAlign: TextAlign.justify,
              maxLines: descTextShowFlag ? 12 : 6),
          if (descText != '-' && descText.isNotEmpty) InkWell(
            onTap: () {
              setState(() {
                descTextShowFlag = !descTextShowFlag;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(descTextShowFlag ? "Свернуть" : "Развернуть",
                    style: const TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
