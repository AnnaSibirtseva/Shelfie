import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shelfie/components/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie/models/inherited_id.dart';
import 'dart:convert';

import '../../../models/book_quote.dart';

class QuoteCard extends StatefulWidget {
  final BookQuote quote;

  const QuoteCard({Key? key, required this.quote}) : super(key: key);

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  //final VoidCallback press;
  late BookQuote quote;
  late int id;

  @override
  void initState() {
    quote = widget.quote;
    super.initState();
  }

  Future<void> saveQuote(int id) async {
    var client = http.Client();
    final jsonString =
    json.encode({});
    try {
      var response = await client.post(
          Uri.https(url, '/interactions/quotes/${quote.getId()}/save'),
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

  Future<void> onQuoteClick() async {
    if (!quote.isQuoteSaved()) {
      await saveQuote(id);
    }
    quote.reverseQuoteSaved();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;
    return InkWell(
      //onTap: press,
      child: Container(
        width: size.width,
        decoration: const BoxDecoration(
            color: secondaryColor,
            image: DecorationImage(
              image: NetworkImage(
                  'https://ie.wampi.ru/2023/03/04/imageef4a214a62549bba.png'),
              alignment: Alignment.topRight,
              //fit: BoxFit.contain,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quote.getQuoteText(),
              textAlign: TextAlign.justify,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: onQuoteClick,
                    child: SizedBox(
                      height: 30,
                      child: quote.isQuoteSaved()
                          ? Image.asset('assets/images/unsave_quote.png')
                          : Image.asset('assets/images/save_quote.png'),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
